defmodule Gataway do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    user = authenticate(conn)
    request_path = conn.request_path

    {:ok, res} = upstream(conn, "http://localhost:5000/#{request_path}", user)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, res.body)
  end

  def authenticate(_conn) do
    # Read from cookies and authenticate

    %{ :username => "shiroyasha", :id => "23123123-123-12-3-123-12-31-23" }
  end

  def upstream(conn, url, user) do
    method = String.downcase(conn.method) |> String.to_atom

    headers = ["x-sem-username": user.username, "x-sem-id": user.id]

    options = []

    # HTTPoison.get(url, headers, options)

    IO.inspect method
    IO.inspect [url, headers, options]

    # hackney raises somthing funky with apply
    # apply(HTTPoison, method, [url, headers, options])

    case method do
      :get ->
        HTTPoison.get(url, headers, options)

      :post ->
        {:ok, body, conn} = Plug.Conn.read_body(conn, length: 1_000_000)

        HTTPoison.post(url, body, headers, options)

      _ ->
        raise "no luck for you"
    end
  end
end
