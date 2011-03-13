% Roman Numerals Code Kata
% http://codingdojo.org/cgi-bin/wiki.pl?KataRomanNumerals

-module(roman_numerals).
-export([convert/1, examples/0]).

-define(ONES, ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]).
-define(TENS, ["X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]).
-define(HUNDREDS, ["C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]).
-define(VALUES, [?ONES, ?TENS, ?HUNDREDS]).

convert(Number) when is_integer(Number), Number > 0, Number =< 3000 ->
    NumberList = to_int_list(integer_to_list(Number)),
    Roman = to_roman(?VALUES, lists:reverse(NumberList)),
    lists:flatten(lists:reverse(Roman)).

to_int_list([Head|Rest]) ->
    {Number, _} = string:to_integer([Head]),
    [Number|to_int_list(Rest)];
to_int_list([]) -> [].
    
to_roman([Values|NextValues], [Head|NextNumbers]) ->
    case Head of
        0 -> to_roman(NextValues, NextNumbers);
        _ -> [lists:nth(Head, Values)|to_roman(NextValues, NextNumbers)]
    end;
to_roman([], [0])  -> []; % Guard clause for end of thousands
to_roman([], [])   -> []; % End case
to_roman([], [ThousandCount|_Empty]) -> ["M"|to_roman([], [ThousandCount - 1])].

% Demo
examples() ->
    examples([1234, 1990, 2008]).
examples([Number|Samples]) ->
    io:format("~w  = ~s~n", [Number, convert(Number)]),
    examples(Samples);
examples([]) -> ok.