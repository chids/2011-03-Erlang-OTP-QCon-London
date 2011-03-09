% Elaboration of the ping/pong exercise (pp.erl) to
% support multiple ping/pong pairs to be created,
% used in send as well as stop.
%
% Example:
% P = [sp:start(), sp:start()].
% sp:send(P, 5).
% sp:stop(P).
%
-module(sp).
-export([start/0, send/2, loop/0, stop/1, nameof/1]).

start() ->
    [spawn(?MODULE, loop, []), spawn(?MODULE, loop, [])].

stop([[Ping, Pong]|Rest]) ->
    stop([Ping, Pong]),
    stop(Rest);
stop([Ping, Pong]) ->
    exit(Ping, kill),
    exit(Pong, kill);
stop([]) -> ok.

send([[Ping, Pong]|Rest], N) ->
    send([Ping, Pong], N),
    send(Rest, N);
send([Ping, Pong], N) ->
    Ping ! {Pong, N};
send([], _) -> ok.

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