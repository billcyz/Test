%% @author billcyz
%% @doc @todo Add description to knk_app.


-module(knk_app).
-behaviour(application).
-export([start/2, stop/1]).

-export([start_app_init/0, start_log/0]).

%% --------------------------------------------------------------

%% Initialize before start knk application
start_app_init() ->
	case start_log() of
		{ok, _Pid} ->
			directory_check(prepare_dir([log, data, user_app]));
		_ ->
			{error, initialize_failed}
	end.

%% Start knk application
start(normal, _Args) ->
	start_app_init(),
	case knk_sup:start_link() of
		{ok, SupPid} ->
			%%open_port(),
			prepare_table(),
			{ok, SupPid};
		E -> E
	end.

%% Stop knk application
stop(_State) -> ok.

%% Check compulsory directory
%% /log, /user_app
-spec directory_check(list()) -> 'ok'.
directory_check([DirH | DirT]) ->
	{AttN, Atts} = DirH,
	case filelib:is_dir(Atts) of
		true ->
			knk_log:write_log(normal,
							  lists:flatten(io_lib:format("~p directory dected~n",
														  [AttN]))),
			directory_check(DirT);
		false -> 
			knk_log:write_log(error,
							  lists:flatten(io_lib:format("~p directory not found~n",
														  [AttN]))),
			S = io_lib:format("mkdir ~p", [Atts]),
			os:cmd(lists:flatten(S))
	end;

directory_check([]) -> ok.

%% Prepare log and user_app directory
-spec prepare_dir(list()) -> list().
prepare_dir(DirL) ->
	[{DirName, Atts} ||
	 DirName <- DirL, {ok, Atts} <- application:get_env(knk, DirName)].

%% Start logging service
start_log() ->
	knk_log:start(),
	case whereis(knk_log) of
		{ok, Pid} ->
			{ok, Pid};
		undefined ->
			{error, log_failed}
	end.

%% Start knk port listener
open_port() ->
	1.

%% Prepare knk ets table
prepare_table() ->
	{ok, UserApp} = application:get_env(knk, app),
	os:cmd(lists:flatten("erl -sname ~p -hidden -detached", [UserApp])),
	case net_adm:ping(UserApp) of
		pong -> ok;
		pang -> no
	end.








