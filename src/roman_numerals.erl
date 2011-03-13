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
    Numbers = to_int_list(integer_to_list(Number)),
    BackwardsRoman = to_roman(?VALUES, lists:reverse(Numbers)),
    lists:flatten(lists:reverse(BackwardsRoman)).

to_int_list([Head|Rest])    -> [list_to_integer([Head]) | to_int_list(Rest)];
to_int_list([])             -> [].
    
to_roman([Values|NextValues], [Number|NextNumbers]) ->
    case Number of
        0 -> to_roman(NextValues, NextNumbers);
        _ -> [lists:nth(Number, Values) | to_roman(NextValues, NextNumbers)]
    end;
to_roman([], [Count|_Empty]) when Count > 0 -> ["M" | to_roman([], [Count - 1])];
to_roman(_, _)   -> [].

% Demo
examples() ->
    examples([1234, 1990, 2008]).

examples([Number|Samples]) ->
    io:format("~w  = ~s~n", [Number, convert(Number)]),
    examples(Samples);
examples([]) -> ok.