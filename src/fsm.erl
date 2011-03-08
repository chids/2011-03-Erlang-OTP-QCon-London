%% FSM exercise
-module(fsm).
-behaviour(gen_fsm).

%% API
-export([start/0, stop/0]).
%% OTP FSM
-export([init/1, handle_info/3, terminate/3, handle_sync_event/4, code_change/4, handle_event/3]).

-record(state, {}).

%%
%% API Functions
%%
start()		-> gen_fsm:start_link({local, ?MODULE}, ?MODULE, [], []).
stop()		-> gen_fsm:sync_send_all_state_event(?MODULE, stop).

%%
%% Local Functions
%%
init(_) ->
	{ok, pending, #state{}}.

handle_sync_event(stop, _From, _StateName, State) ->
    {stop, normal, ok, State};
handle_sync_event(_, _From, StateName, State) ->
	io:format("handle sync event ", []),
	{next_state, StateName, State}.

handle_event(_Event, StateName, State) ->
	io:format("handle event", []),
	{next_state, StateName, State}.

handle_info(_, _, _) ->
	io:format("handle info", []),
	ok.

terminate(_Reason, _StateName, _State) -> ok.

code_change(_, _, _, _) -> ok.