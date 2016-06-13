defmodule Lib_string do

  def list_to_string([head | tail], string) do
    if string != "" do
      list_to_string(tail, string <> "/" <> head)
    else
      list_to_string(tail,head)
    end
  end

  def list_to_string([], string), do: string

  def tuple_to_ip(tuple, size \\ 4, accumulator \\ "") when size > 0 do
    value = to_string(elem(tuple, size-1))
    if size-1 > 0 do
      value = "." <> value
    end

    tuple_to_ip(tuple, size-1, value <> accumulator )
  end

  def tuple_to_ip(_, 0, accumulator), do: accumulator

end
