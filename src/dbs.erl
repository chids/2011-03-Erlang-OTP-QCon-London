%
% OTP gen_server tutorial, make a gen_server around db.erl
%
-module(dbs).
-behaviour(gen_server).
-vsn('1.0').

% API
-export([start/0, stop/0, read/1, write/2, delete/1, match/1]).

% OTP
-export([init/1, handle_cast/2, handle_call/3, terminate/2, code_change/3, handle_info/2]).

%%% API
stop()              -> gen_server:cast(?MODULE, stop).
read(Key)           -> gen_server:call(?MODULE, {read, Key}).
match(Key)          -> gen_server:call(?MODULE, {match, Key}).
delete(Key)         -> gen_server:cast(?MODULE, {delete, Key}).
write(Key, Value)   -> gen_server:cast(?MODULE, {write, Key, Value}).
start()             -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%% OTP gen_server

init(_Args) ->
    {ok, db:new()}.

handle_call({read, Key }, _From, Database) ->
    {reply, db:read(Key, Database), Database};
handle_call({match, Key }, _From, Database) ->
    {reply, db:match(Key, Database), Database}.

handle_cast(stop, Database) ->
    {stop, normal, Database};
handle_cast({write, Key, Value}, Database) ->
    {noreply, db:write(Key, Value, Database)};
handle_cast({delete, Key}, Database) ->
    {noreply, db:delete(Key, Database)}.

terminate(_Reason, _Database) -> ok.

code_change(_OldVersion, Database, _Extra) -> {ok, Database}.

handle_info(_Info, State) -> {noreply, State}.