Mix.install([
  {:ex_json_schema, "0.9.2"},
  {:jason, "1.4.0"}
])

Code.require_file("processor.ex")

schema = %{
  "type" => "object",
  "properties" => %{
    "cmd" => %{
      "type" => "string",
      "enum" => Processor.commands() |> Map.keys()
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

process = fn (map, schema) ->
  case ExJsonSchema.Validator.validate(schema, map) do
    :ok ->
      Processor.commands()[map["cmd"]].(map["data"])
    {:error, errors} ->
      errors
  end
end

IO.read(:stdio, :line)
|> Jason.decode!()
|> process.(schema)
|> IO.inspect()
