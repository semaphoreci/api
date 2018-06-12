defmodule Gataway do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    user = authenticate(conn)
    request_path = conn.request_path

    {:ok, res} = upstream(conn, "localhost:5000/#{request_path}", user)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, res.body)
  end

  def authenticate(_conn) do
    # Read from cookies and authenticate

    %{ :username => "shiroyasha", :id => "23123123-123-12-3-123-12-31-23" }
  end

  def upstream(conn, url, user) do
    method = "#{String.downcase(conn.method)}!" |> String.to_atom

    headers =
      conn.req_headers
      # |> Keyword.merge([{"x-sem-username", user.username}])
      # |> Keyword.merge([{"x-sem-id", user.id}])

    options = []

    apply(HTTPoison, method, [url, headers, options])
  end
end
