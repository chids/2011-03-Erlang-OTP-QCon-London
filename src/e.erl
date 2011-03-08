%
% Various pattern matching, guard and list exercies
%
-module(e).
-export([b_not/1, b_and/2, b_or/2, b_nand/2, sum/1, sum/2, o1/1, r1/1, o2/1, r2/1]).

% e:b_not(false) -> true
% e:b_and(false, true) -> false
% e:b_and(e:b_not(e:b_and(true, false)), true) -> true

b_not(true)		-> false;
b_not(false)	-> true.

b_and(true, true)	-> true;
b_and(_, _)			-> false.

b_or(false, false)	-> false;
b_or(_, _)			-> true.

b_nand(A, B)		-> b_not(b_and(A, B)).

%% - - - - - - - - -

sum(0)	-> 0;
sum(N)	-> N + sum(N - 1).

% If N > M, error
% sum(1, 3) => 6
% sum(6, 6) => 6
sum(N, N)	-> N;
sum(N, M)	-> N + sum(N + 1, M).

%% - - - - - - - - -

% First attempt at ordered and reverse
% Apparently this is a bad way of creating lists
o1(N) when N =< 0	-> [];
o1(N)				-> o1(N - 1) ++ [N].

r1(N) when N =< 0	-> [];
r1(N)				-> [N] ++ r1(N - 1).

% Second attempt at orderd and reverse
% after being lectured by Francesco
o2(Illegal) when Illegal =< 0	-> [];
o2(Max)							-> o2(1, Max).

o2(Max, Max)		-> [Max];
o2(Next, Max)		-> [Next | o2(Next + 1, Max)].

r2(Illegal) when Illegal =< 0	-> [];
r2(From)						-> r2(From, 1).

r2(To, To)		-> [To];
r2(From, To)	-> [From | r2(From - 1, To)].