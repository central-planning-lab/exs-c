Mix.install([
  {:ex_json_schema, "0.9.2"},
  {:jason, "1.4.0"}
])

defmodule Processor do
  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif('./processor', 1)
  end

  def avg(_) do
    raise "NIF avg/1 not implemented"
  end

  def max(_) do
    raise "NIF max/1 not implemented"
  end

  def min(_) do
    raise "NIF min/1 not implemented"
  end
end

schema = %{
  "type" => "object",
  "properties" => %{
    "cmd" => %{
      "type" => "string",
      "enum" => ["avg", "max", "min"]
    },
    "data" => %{
      "type" => "array",
      "items" => %{
        "type" => "integer"
      }
    }
  },
  "required" => ["cmd", "data"]
} |> ExJsonSchema.Schema.resolve()

commands = %{
  "avg" => &Processor.avg/1,
  "max" => &Processor.max/1,
  "min" => &Processor.min/1
}

process = fn (map, schema) ->
  case ExJsonSchema.Validator.validate(schema, map) do
    :ok ->
      commands[map["cmd"]].(map["data"])
    {:error, errors} ->
      errors
  end
end

IO.read(:stdio, :line)
|> Jason.decode!()
|> process.(schema)
|> IO.inspect()
