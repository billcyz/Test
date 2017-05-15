%% @author billcyz
%% @doc @todo Add description to test.


-module(test).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Internal functions
%% ====================================================================

-spec combine_data(tuple(), integer(), list(), atom(), tuple()) -> binary().
combine_data(IP, Port, RequestType, RequestInfo) ->
	BIP = list_to_binary(tuple_to_list(IP)),
	BReType = list_to_binary(atom_to_list(RequestType)),
	
	<<BIP, Port:16/integer, BReType, "RequestInfo">>.



