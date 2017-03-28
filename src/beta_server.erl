%% @author billcyz
%% @doc @todo Add description to beta_server.


-module(beta_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([start_link/0, add/1, minus/1, stop/0]).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_Args) ->
	io:format("Starting beta server ~p ~p~n", [?MODULE, self()]),
	{ok, beta_state()}.

add(X) ->
	gen_server:call(?MODULE, {add, X}).

minus(X) ->
	gen_server:call(?MODULE, {minus, X}).

stop() ->
	gen_server:cast(?MODULE, stop).

handle_call({add, X}, _From, _State) ->
	{reply, beta_function:add(X), _State};

handle_call({minux, X}, _From, _State) ->
	{reply, beta_function:minus(X), _State}.


handle_cast(stop, _State) ->
	{stop, normal, _State}.

handle_info(_Info, _State) ->
	{noreply, _State}.

code_change(_OldVsn, _State, _Extra) ->
	{ok, _State}.

terminate(normal, _State) ->
	ok.

beta_state() ->
	{ok, beta_server}.

