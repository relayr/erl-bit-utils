%%------------------------------------------------------------------------------
%% @author kuba.odias
%% @copyright relayr 2009-2018
%%------------------------------------------------------------------------------
-module(bit_utils_tests).

-ifdef(TEST).

%%------------------------------------------------------------------------------
%% Include files
%%------------------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").

%% =============================================================================
%% Unit tests
%% =============================================================================

bits_to_bytes_test() ->
    Res1 = bit_utils:bits_to_bytes(2),
    ?assertEqual(1,Res1),
    Res2 = bit_utils:bits_to_bytes(128),
    ?assertEqual(16,Res2).

bytes_to_bits_test() ->
    Res1 = bit_utils:bytes_to_bits(1),
    ?assertEqual(8,Res1),
    Res2 = bit_utils:bytes_to_bits(128),
    ?assertEqual(1024,Res2).

lowest_bit_set_test() ->
    ?assertEqual(undefined, bit_utils:lowest_bit_set(0)),
    ?assertEqual(0, bit_utils:lowest_bit_set(1)),
    ?assertEqual(0, bit_utils:lowest_bit_set(3)),
    ?assertEqual(1, bit_utils:lowest_bit_set(6)),
    ?assertEqual(3, bit_utils:lowest_bit_set(8)),
    ?assertEqual(0, bit_utils:lowest_bit_set(9)).

bits_set_test() ->
    Len1 = 0,
    <<Bits1:Len1>> = <<>>,
    {ok, R1} = bit_utils:bits_set(Bits1, Len1),
    ?assertEqual([], R1),

    Len2 = 3,
    {ok, R2} = bit_utils:bits_set(2#000, Len2),
    ?assertEqual([], R2),

    Len3 = 5,
    {ok, R3} = bit_utils:bits_set(2#10010, Len3),
    ?assertEqual([0, 3], R3),

    Len4 = 3,
    {ok, R4} = bit_utils:bits_set(2#110, Len4),
    ?assertEqual([0, 1], R4).

set_bits_test() ->
    Len1 = 0,
    {ok, R1} = bit_utils:set_bits([], Len1),
    ?assertEqual(0, R1),

    Len2 = 4,
    {ok, R2} = bit_utils:set_bits([], Len2),
    ?assertEqual(2#0000, R2),

    Len3 = 6,
    {ok, R3} = bit_utils:set_bits([2,5], Len3),
    ?assertEqual(2#001001, R3),

    Len4 = 3,
    {ok, R4} = bit_utils:set_bits([0,1], Len4),
    ?assertEqual(2#110, R4).

-endif.
