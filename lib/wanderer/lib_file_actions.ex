defmodule Lib_File_Actions do

  defp pygmentize(file_path, language) do
    System.cmd("pygmentize", ["-l", language, "-f", "html", "-O", "style=colorful,linenos=1", file_path])
  end

  def with_extension(connection, "py", file_path) do
    Lib_Wanderer.html_page(connection,
              List.last(String.split(file_path, "/")),
              elem(pygmentize(file_path, "python"), 0))
  end

  def with_extension(connection, "mp3", file_path) do
    Lib_response.stream(connection, file_path)
  end

  def with_extension(connection, "mp4" , file_path) do
    Lib_response.stream(connection, file_path)
  end

  def with_extension(connection, "m4v" , file_path) do
    Lib_response.stream(connection, file_path)
  end

  def with_extension(connection, "mkv" , file_path) do
    Lib_response.stream(connection, file_path)
  end

  def with_extension(connection, _ , file_path) do
    Lib_response.download(connection, file_path)
  end

end
