defmodule Lib_Wanderer do

  def file_indexer(conn, path, content) do
    Lib_response.html_page(conn, Application.get_env(:shiren, :path_template),
                          [ wanderer_title: Application.get_env(:shiren, :site_title),
                            wanderer_body: Lib_Link.generate_html_links(elem(content, 1), path),
                            wanderer_path: path,
                            wanderer_number_files: "Number of files: #{elem(content, 2)}",
                            wanderer_files_size: "Total files size:#{Float.round(elem(content,3)/1024000, 2)}MB"])
  end

  def html_page(conn, page_name, body) do
    Lib_response.html_page(conn, Application.get_env(:shiren, :path_template),
                          [ wanderer_title: Application.get_env(:shiren, :site_title),
                            wanderer_body: body,
                            wanderer_path: page_name,
                            wanderer_number_files: "",
                            wanderer_files_size: ""])
  end

  def html_404(conn) do
    Lib_response.html_page(conn, Application.get_env(:shiren, :path_template),
                          [ wanderer_title: Application.get_env(:shiren, :site_title),
                            wanderer_body: "<center><h1>404!</h1><br>\n<h2>Are you lost in this dungeon?</h2></center>",
                            wanderer_path: "404!",
                            wanderer_number_files: "",
                            wanderer_files_size: ""])
  end

end
