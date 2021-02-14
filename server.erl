-module(server).
-export([start/0]).

start()->
  {ok, ListenSocket} = gen_tcp:listen(os:getenv("PORT"), [binary, {packet, 4}, {active, true}, {reuseaddr, true}]),
  spawn(fun() -> per_connect(ListenSocket) end).

per_connect(ListenSocket) ->
  {ok, Socket} = gen_tcp:accept(ListenSocket),
  spawn(fun() -> per_connect(ListenSocket) end),
  loop(Socket).

loop(Socket) ->
  receive
    {tcp, Socket, Data} ->
      io:format("Msg from server: ~p~n", [binary_to_list(Data)]),
      loop(Socket);
    {tcp_closed, Socket} ->
      io:format("closed~n"),
      gen_tcp:close(Socket)
  end.