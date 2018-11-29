%%------------------------------------------------------------------------------
%% @author kuba.odias
%% @copyright relayr 2009-2018
%% @doc Miscellaneous functions for Erlang bits processing.
%% @end
%%------------------------------------------------------------------------------
-module(bit_utils).

%%------------------------------------------------------------------------------
%% Include files
%%------------------------------------------------------------------------------

%%------------------------------------------------------------------------------
%% Function exports
%%------------------------------------------------------------------------------
-export([
    bits_set/2,
    set_bits/2,
    lowest_bit_set/1,
    bytes_to_bits/1,
    bits_to_bytes/1,
    rest_of_byte_size_alignment/1
]).

%% =============================================================================
%% Exported functions
%% =============================================================================

-spec bits_set(Integer :: non_neg_integer(), Length :: pos_integer()) -> {ok, [non_neg_integer(), ...]}.
bits_set(Integer, Length) ->
    bits_set(Integer, Length, []).

-spec set_bits(BitList :: [non_neg_integer()], Length :: pos_integer()) -> {ok, non_neg_integer()}.
set_bits(BitList, Length) ->
    set_bits(BitList, Length, 0).

-spec lowest_bit_set(N :: non_neg_integer()) -> LowestBitSet :: non_neg_integer().
lowest_bit_set(0) ->
    0;
lowest_bit_set(N) ->
    lowest_bit_set(N, 1).

-spec bytes_to_bits(Bytes :: integer()) -> Bits :: integer().
bytes_to_bits(Bytes) ->
    Bytes*8.

-spec bits_to_bytes(Bits :: integer()) -> Bytes :: integer().
bits_to_bytes(Bits) ->
    trunc(math:ceil(Bits/8)).

%% @doc Get rest number of bits when aligned to a byte.
rest_of_byte_size_alignment(BitSize) when (BitSize rem 8 =:= 0) ->
    0;
rest_of_byte_size_alignment(BitSize) ->
    (BitSize div 8 + 1) * 8 - BitSize.

%% =============================================================================
%% Local functions
%% =============================================================================

-spec bits_set(Integer :: non_neg_integer(), Length :: non_neg_integer(), BitList :: [non_neg_integer()]) -> {ok, [non_neg_integer(), ...]}.
bits_set(_Integer, 0, BitList) ->
    {ok, BitList};
bits_set(Integer, Length, BitList) ->
    NewBitList =
        if Integer rem 2 =:= 0 ->
            BitList;
        Integer rem 2 =:= 1 ->
            [Length - 1 | BitList]
        end,
    bits_set(Integer bsr 1, Length - 1, NewBitList).

-spec set_bits(BitList :: [non_neg_integer()], Length :: non_neg_integer(), Integer :: non_neg_integer()) -> {ok, non_neg_integer()}.
set_bits([], _Length, Integer) ->
    {ok, Integer};
set_bits([Bit | RestOfBitList], Length, Integer) ->
    set_bits(RestOfBitList, Length, Integer + (1 bsl (Length - Bit - 1))).

-spec lowest_bit_set(N :: non_neg_integer(), Pos :: non_neg_integer()) -> LowestBitSet :: non_neg_integer().
lowest_bit_set(N, Pos) ->
    if N rem 2 =:= 1 ->
        Pos;
    true ->
        lowest_bit_set(N bsr 1, Pos + 1)
    end.