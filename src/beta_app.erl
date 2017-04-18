%% @author billcyz
%% @doc @todo Add description to beta_app.


-module(beta_app).
-behaviour(application).
-export([start/2, stop/1]).


-export([start_app_client/0,
		 init/1]).

-define(MAX_RESTART, 2).
-define(MAX_SECONDS, 60).

%% Start normal application client
start_app_client() ->
	supervisor:start_child(app_client_sup, []).

%% start_srv() ->
%% 	1.

start(normal, _Args) ->
	{ok, Port} = application:get_env(beta_app, port),
	supervisor:start_link({local, ?MODULE}, ?MODULE, [Port]).

stop(_State) -> ok.

init([Port]) ->
	{ok, {one_for_one, ?MAX_RESTART, ?MAX_SECONDS},
	 [{beta_app_socket_sup,
	   {beta_app_socket_sup, start_link, [Port]},
	   infinity, supervisor,
	   [beta_app_client_sup]}]}.


