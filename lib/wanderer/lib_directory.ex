defmodule Lib_directory do

  def is_directory(file) when is_tuple(file) do
    file[:file_type] == :directory
  end

  def is_directory(file) when is_binary(file) do
    {result, info_tuple} = :file.read_file_info file
    if result == :ok do
      if elem(info_tuple,2) == :regular do
        :false
      else
        :true
      end
    else
      :nexist
    end
  end

  def is_file(file_map) do
    not is_directory(file_map)
  end

  def get_extension(file_map) do
    String.split(file_map[:file_name], ".") |> List.last
  end

  def sort_content([head | tail], list, base_path) do
    complete_path =  to_char_list(base_path) ++ '/' ++ head
    {result, info_tuple} = :file.read_file_info(complete_path)
    if result == :ok do
      sort_content(tail, list ++ [%{:file_name => to_string(head),
                      :byte_size => elem(info_tuple,1),
                      :file_type => elem(info_tuple,2),
                      :rw => elem(info_tuple,3)
                    }], base_path )
    else
      sort_content(tail, list, base_path)
    end
  end

  def sort_content([], list, _ ) do
    list
  end

  defp total_files_size([head | tail], acc) do
    total_files_size(tail, acc + head[:byte_size])
  end

  defp total_files_size([], acc) do
    acc
  end

  def get_directory_content(path) do
    {exit_code, content_list} = :file.list_dir(to_char_list(path))
    if exit_code == :ok do
      content = sort_content(content_list, [], path)
      {true, content, length(content), total_files_size(content, 0)}
    else
      {false, [], 0, 0}
    end
  end

end
