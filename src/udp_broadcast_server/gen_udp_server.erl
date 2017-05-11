%% @author billcyz
%% @doc @todo Add description to gen_udp_server.


-module(gen_udp_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


-export([start_link/2, request_comp/1]).

-record(state, {socket,
				port,
				local_ip,
				broad_ip}).

start_link(Port, Nic) ->
	{ok, Socket} = gen_udp:open(Port, [binary, {active, false},
									   {reuseaddr, true},
									   {broadcast, true}]),
	[{_, BAddr}] = broadcast_ip(Nic),
	[{_, LAddr}] = local_ip(Nic),
	gen_server:start_link(?MODULE, [Socket, Port, BAddr, LAddr], []).

request_comp(AppName) ->
	gen_server:cast(?MODULE, {request_comp, AppName}).

handle_cast({request_comp, AppName}, #state{socket = Socket, 
											port = Port,
											local_ip = LAddr,
											broad_ip = BAddr} = State) ->
	gen_udp:send(Socket, BAddr, Port, 
				 io_lib:format("[~p, ~p]", [request_comp, 
											{AppName, LAddr}])),
	{noreply, State}.

handle_call(_Request, _From, State) ->
	{noreply, State}.

handle_info({udp, Socket, Addr, Port, Data}, #state{socket = LSocket, 
													 local_ip = LAddr} = State) ->
	inet:setopts(LSocket, [{active, once}]),
	if
		Addr =:= LAddr andalso Socket =:= LSocket ->
			{noreply, State};
		Addr =/= LAddr ->
			case parse_data(Data) of
				distribute_request ->
					gen_udp:send(LSocket, LAddr, Port, "received");
				other_request ->
					gen_udp:send(LSocket, LAddr, Port, "other")
			end,
			{noreply, State}
	end.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

init([Socket, Port, BAddr, LAddr]) ->
	{ok, #state{socket = Socket, port = Port, local_ip = LAddr,
				broad_ip = BAddr}}.


%% Get broadcast ip address according to network
%% interface
-spec broadcast_ip(any()) -> term().
broadcast_ip(Nic) ->
	{ok, Addrs} = inet:getifaddrs(),
	[{Nic, Addr} || {NicName, Opts} <- Addrs, NicName =:= Nic,
					{broadaddr, Addr} <- Opts, size(Addr) =:= 4].

%% Get ip address according to network interface
local_ip(Nic) ->
	{ok, Addrs} = inet:getifaddrs(),
	[{Nic, Addr} || {NicName, Opts} <- Addrs, NicName =:= Nic,
					{addr, Addr} <- Opts, size(Addr) =:= 4].

parse_data(Data) ->
	DataL = binary_to_list(Data),
	{ok, Token, _} = erl_scan:string(DataL ++ "."),
	{ok, Term} = erl_parse:parse_term(Token),
	direct_traffic(Term).

direct_traffic([TrafficType, _Traffic]) ->
	case TrafficType of
		request_comp ->
			distribute_request;
		_ ->
			other_request
	end.

