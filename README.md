# EXS - C

This is a simple, experimental attempt to execute functions written in C from Elixir.

Pass JSON strings to an Elixir [script](https://elixir-lang.org/getting-started/modules-and-functions.html#scripted-mode).
The Elixir script parses the JSON and validates it using [JSON Schema](https://json-schema.org).

To compile the NIFs:
```
%> ERL_ROOT=/usr/local/Cellar/erlang/25.3.1/lib/erlang
%> gcc -fPIC -o processor.so processor.c -I ${ERL_ROOT}/usr/include \
   -bundle -bundle_loader ${ERL_ROOT}/erts-13.2.1/bin/beam.smp
```

Run the script and pass it a calculation to perform:
```
%> elixir processor.exs
{"cmd": "min", "data": [1, 2, 3]}
```