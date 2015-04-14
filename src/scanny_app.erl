-module(scanny_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% Hacking convencience
-export([start/0]).

%% inotify "behaviour"
-export([inotify_event/3]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    scanny_sup:start_link().

stop(_State) ->
    ok.

%% ===================================================================

start() ->
    {ok, _} = application:ensure_all_started(scanny),
    Ref = inotify:watch("/tmp/bob"),
    ok = inotify:add_handler(Ref, ?MODULE, arrrr).

%% ===================================================================

inotify_event(Arg, EventTag, Msg) ->
    io:format("Arg: ~p~nEventTag: ~p~nMsg ~p~n~n", [Arg, EventTag, Msg]).
