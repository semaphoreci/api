defmodule ProjectsApi do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    IO.inspect conn.req_headers

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello")
  end

end
