%% Supervisor exercise for gen_server (db.erl)
-module(dbs_sup).
-behaviour(supervisor).
-vsn('1.0').
-export([start/0, init/1, stop/0]).

start() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop() ->
	exit(whereis(?MODULE), shutdown).

init(_) ->
	{ok, {{one_for_one, 2, 3600}, [child(dbs)]}}.

child(Module) ->
	{Module, {Module, start, []}, permanent, 2000, worker, [Module] }.