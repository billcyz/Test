%% @author billcyz
%% @doc @todo Add description to gen_udp_server_sup.


-module(gen_udp_server_sup).
-behaviour(supervisor).
-export([init/1]).


-export([start/1]).

-define(BROADCAST_PORT, 4399).

start(Nic) ->
	supervisor:start_link(?MODULE, [Nic]).

init([Nic]) ->
	{ok, {{simple_one_for_one, 0, 1},
		  [{gen_udp_server,
			{gen_udp_server, start_link, [?BROADCAST_PORT, Nic]},
			temporary, infinity, worker,
			[gen_udp_server]}]}}.

