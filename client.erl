-module(client).
-export([send/1]).

send(Message) ->
  {ok, Socket} = gen_tcp:connect("localhost", os:getenv("PORT"), [binary, {packet, 4}]),
  ok = gen_tcp:send(Socket, list_to_binary(Message)),
  gen_tcp:close(Socket).
