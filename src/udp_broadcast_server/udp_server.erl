%% @author billcyz
%% @doc @todo Add description to udp_server.


-module(udp_server).

-export([start/0, request_distribute/3]).

-define(BROADCAST_PORT, 4399).


%% Start broadcast udp port
start() ->
	{ok, Socket} = gen_udp:open(?BROADCAST_PORT, [binary,
												  {active, false},
												  {broadcast, true}]),
	socket_loop(Socket).

socket_loop(Socket) ->
	inet:setopts(Socket, [{active, once}]),
	receive
		{udp, Socket, IP, InPortNum, Packet} ->
			io:format("Server ~p received: ~p~n", [self(), Packet]),
			gen_udp:send(Socket, IP, InPortNum,
						 io_lib:format("~p received message", [node()])),
			socket_loop(Socket)
	end.

%% Get broadcast ip address according to network
%% interface
-spec broadcast_ip(any()) -> term().
broadcast_ip(Nic) ->
	{ok, Addrs} = inet:getifaddrs(),
	[{Nic, Addr} || {NicName, Opts} <- Addrs, NicName =:= Nic,
					{addr, Addr} <- Opts, size(Addr) =:= 4].

%% Send distribute broadcast request
-spec request_distribute(term(), term(), binary()) -> 'ok'.
request_distribute(Nic, Socket, Data) ->
	[{_, Addr}] = broadcast_ip(Nic),
	gen_udp:send(Socket, Addr, ?BROADCAST_PORT, Data),
	receive_request(Socket).

receive_request(Socket) ->
	inet:setopts(Socket, [{active, once}]),
	receive
		{udp, Socket, _IP, _InPortNum, Packet} ->
			[_SIP, _SPort, PacketInfo] = parse_packet(Packet),
			case PacketInfo of
				{distribute, _} -> ok;
				{app, _} -> app;
				_ -> asd
			end,
			gen_udp:close(Socket)
	end.

%% Parse traffic
%% Message should contain requestor's IP, Port, Node?
%% <<source_ip, source_port, node_id/name, app_name, 
%% timestamp, request_type, data>>
-spec parse_packet(binary()) -> list().
parse_packet(Data) ->
	<<SIP:4/binary, SPort:16/integer, RestInfo/binary>> = Data,
	BinL = binary_to_list(RestInfo),
	{ok, Token, _} = erl_scan:string(BinL ++ "."),
	{ok, Term} = erl_parse:parse_term(Token),
	[list_to_tuple(binary_to_list(SIP)), SPort, Term].







