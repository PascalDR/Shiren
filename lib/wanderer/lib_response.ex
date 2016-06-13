defmodule Lib_response do

  def download(connection, file_path) do
    IO.puts("[" <> Lib_string.tuple_to_ip(connection.remote_ip) <> "] request for file " <> file_path <> " for download")
    connection |>
    Plug.Conn.put_resp_content_type("application/force-download") |>
    Plug.Conn.put_req_header("Content-Disposition" , "attachment; filename=\""
      <> (String.split(file_path, "/") |> List.last) <>"\"" ) |>
    Plug.Conn.send_resp(200, File.read!(file_path))
  end

  def stream(connection, file_path) do
    IO.puts("[" <> Lib_string.tuple_to_ip(connection.remote_ip) <> "] request for file " <> file_path <> " for stream")
    connection |>
    Plug.Conn.put_resp_content_type("application/octet-stream") |>
    Plug.Conn.put_req_header("Content-Disposition" , "application/octet-stream") |>
    Plug.Conn.put_req_header("Content-Disposition" , "attachment; filename=\""
      <> (String.split(file_path, "/") |> List.last) <>"\"" ) |>
    Plug.Conn.send_resp(200, File.read!(file_path))
  end

  def html_page(connection, html_template, options, resp_code \\ 200) do
    html_page = EEx.eval_file(html_template, options)
    connection |>
      Plug.Conn.put_resp_content_type("text/html") |>
      Plug.Conn.send_resp(resp_code, html_page)
  end

end
