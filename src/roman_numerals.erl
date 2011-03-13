% Roman Numerals Code Kata
% http://codingdojo.org/cgi-bin/wiki.pl?KataRomanNumerals
%
% Made as an alternate solution to:
% https://github.com/froderik/roman_numeral_katas/blob/master/erlang/numeral_to_roman.erl
%
% Implemented from this reasoning:
%
% "A practical way to write a Roman number is to consider the modern Arabic
% numeral system, and separately convert the thousands, hundreds, tens, and
% ones" - http://en.wikipedia.org/wiki/Roman_numerals
%
-module(roman_numerals).
-export([convert/1, examples/0]).

-define(ONES,       ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]).
-define(TENS,       ["X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]).
-define(HUNDREDS,   ["C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]).
-define(VALUES, [?ONES, ?TENS, ?HUNDREDS]).

convert(Number) when Number > 0, Number =< 3000 ->
    Numbers = toIntList(integer_to_list(Number)),
    BackwardsRoman = toRoman(?VALUES, lists:reverse(Numbers)),
    lists:flatten(lists:reverse(BackwardsRoman)).

toIntList([Head|Rest]) -> [list_to_integer([Head])|toIntList(Rest)];
toIntList([])          -> [].
    
toRoman([Values|NextValues], [Number|NextNumbers]) -> [lookup(Number, Values)|toRoman(NextValues, NextNumbers)];
toRoman([], [Count|_]) when Count > 0              -> ["M"|toRoman([], [Count - 1])];
toRoman(_, _)                                      -> [].

lookup(0, _)            -> [];
lookup(Number, Values)  -> lists:nth(Number, Values).

% Demo
examples() -> examples([1, 10, 100, 1000, 12, 123, 1234, 1990, 2008]).

examples([Number|Samples]) ->
    io:format("~w \t= ~s~n", [Number, convert(Number)]),
    examples(Samples);
examples([]) -> ok.