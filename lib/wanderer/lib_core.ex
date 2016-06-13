defmodule Lib_core do

  defp set_root_path(path) do
    { _ , ext_code} = to_char_list(path) |> :shell_default.cd
  end

  def init_shiren() do
    path = Application.get_env(:shiren, :root_path)

    if path != [] and !set_root_path(path) do
      false
    end

    true
  end

end
