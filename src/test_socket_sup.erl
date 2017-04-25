%% @author billcyz
%% @doc @todo Add description to test_socket_sup.


-module(test_socket_sup).
-behaviour(supervisor).
-export([init/1]).

-export([start_link/1]).

-define(MAX_RESTART, 2).
-define(MAX_SECONDS, 60).
-define(SERVER, ?MODULE).
%%-define(IPAddr, {192,168,1,100}).

start_link(Port) ->
	%%IPAddr = getip(),
	supervisor:start_link({local, ?SERVER}, ?MODULE, [Port]).

init([Port]) ->
	start_app_socket(),
	{ok, {{simple_one_for_one, ?MAX_RESTART, ?MAX_SECONDS},
		  [{beta_app_socket_srv,
			{test_socket_srv, start_link, [Port]},
			transient, worker,
			[test_socket_srv]}]}}.

start_app_socket() ->
	[start_socket() || _ <- lists:seq(1, 5)].

start_socket() ->
	supervisor:start_child(?MODULE, []).

%% getip() ->
%% 	{ok, Addr} = application:get_env(beta_app, ip),
%% 	Addr.



