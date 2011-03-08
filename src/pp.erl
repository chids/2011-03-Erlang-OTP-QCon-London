%
% Process message passing tutorial: A ping/pong module
%
-module(pp).
-export([start/0, send/1, loop/0, stop/0, nameof/1]).

start() ->
	register(ping, spawn(?MODULE, loop, [])),
	register(pong, spawn(?MODULE, loop, [])),
	started.

stop() ->
	exit(whereis(ping), kill),
	exit(whereis(pong), kill),
	stopped.

send(N) ->
	ping ! {pong, N}.

loop() ->
	receive
		{From, N} when N > 0 ->
			io:format("~p -> ~p: ~p~n", [nameof(From), nameof(self()), N]),
			From ! {self(), N - 1},
			loop();
		_ ->
			loop()
	end.

nameof(Pid) when is_atom(Pid) -> Pid;
nameof(Pid) ->
	case process_info(Pid, registered_name) of
		{_, Name} -> Name;
		_ -> unknown
	end.