%% @author billcyz
%% @doc @todo Add description to test.


-module(test).

%% ====================================================================
%% API functions
%% ====================================================================
-export([add/0, show/0]).
-export([test/1, parse_str/1]).

-export([change_data/1]).

%% ====================================================================
%% Internal functions
%% ====================================================================

-define(PORT, add()).

add() ->
	1000.

show() ->
	?PORT.

test(X) ->
	list_to_string(X).

list_to_string(X) ->
	{ok, T, _} = erl_scan:string(X++"."),
	case erl_parse:parse_term(T) of
		{ok, Term} ->
			Term;
		{error, Error} ->
            Error
    end.

parse_str(Input) ->
	"{" ++ Tail = Input,
	case Tail of
		"request, " ++ MFT -> [request, strip(MFT)]
	end.

strip(Input) ->
	lists:reverse(tl(lists:reverse(Input))).


change_data(Data) ->
	%% asdasdasd
	%% asdasdasdasd
	NewData = <<"okokokokokokokokokkookokok", Data/binary>>,
	NewData.


