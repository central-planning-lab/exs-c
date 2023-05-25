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

  def commands, do: %{ "avg" => &Processor.avg/1, "max" => &Processor.max/1, "min" => &Processor.min/1 }
end
