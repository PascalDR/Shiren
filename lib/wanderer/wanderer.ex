defmodule Wanderer do
  use Router

  def route("GET", resource, conn) do
    if resource == [] do
      content = Lib_directory.get_directory_content(Application.get_env(:shiren, :path_root))
      conn |> Lib_Wanderer.file_indexer("", content)
    else
      complete_path = Application.get_env(:shiren, :path_root) <> Lib_string.list_to_string(resource,"") |> String.replace("%20", "\ ")
      path = List.last(resource) |> String.replace("%20", "\ ")
      case Lib_directory.is_directory(complete_path) do
        :true ->    Lib_Wanderer.file_indexer(conn, path, Lib_directory.get_directory_content(complete_path))
        :false ->   Lib_File_Actions.with_extension(conn, String.split(path, ".") |> List.last, complete_path)
        :nexist ->  Lib_Wanderer.html_404(conn)
      end
    end
  end

end
