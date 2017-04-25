%% @author billcyz
%% @doc @todo Add description to test_socket_sup.

%% Test
-module(test_socket_sup).
-behaviour(supervisor).
-export([init/1]).

-export([start_link/1, start_socket/0]).

-define(MAX_RESTART, 2).
-define(MAX_SECONDS, 60).
-define(SERVER, ?MODULE).
%%-define(IPAddr, {192,168,1,100}).

start_link(Port) ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, [Port]).

init([Port]) ->
	{ok, Socket} = gen_tcp:listen(Port, [bninary, {active, false},
										 {reuseaddr, true}]),
	start_app_socket(),
	{ok, {{simple_one_for_one, ?MAX_RESTART, ?MAX_SECONDS},
		  [{test_socket_srv,
			{test_socket_srv, start_link, [Socket]},
			temporary, brutal_kill, worker,
			[test_socket_srv]}]}}.

start_app_socket() ->
	[start_socket() || _ <- lists:seq(1, 5)].

start_socket() ->
	supervisor:start_child(?SERVER, []).




