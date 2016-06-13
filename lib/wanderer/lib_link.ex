defmodule Lib_Link do

  def generate_html_links(resource_list, base_path, new_lines \\ 1) do
    nl_tag = String.duplicate("<br>", new_lines)
    create_links_string(resource_list, base_path, nl_tag, "")
  end

  defp create_links_string([head | tail], base_path, nl_tag, acc) do
    if (Application.get_env(:shiren, :include_hidden_files) == false) and !String.starts_with?(head[:file_name], ".") do
      link = "<li><a href='" <> base_path <> "/" <> head[:file_name]
        <> "'>" <> head[:file_name] <> "</a></li>\n"
      create_links_string(tail, base_path, nl_tag, acc <> link)
    else
      create_links_string(tail, base_path, nl_tag, acc)
    end
  end

  defp create_links_string([], _ , _, acc), do: acc

end
