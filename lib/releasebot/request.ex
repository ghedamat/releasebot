defmodule Request do
  @user_agent [{"User-agent", "releasebot"}]

  def process_response(response) do
    status_code = response.status_code
    body = response.body

    response = unless body == "", do: body |> JSX.decode!, else: nil

    if (status_code == 200), do: response, else: {status_code, response}
  end

  def get(url, params \\ [], headers \\ []) do
    _request(:get, build_url(url, params), "", headers)
  end

  def _request(method, url, body \\ "", headers) do
    json_request(method, url, body, auth_headers(headers))
  end

  def auth_headers(headers \\ []) do
    @user_agent ++ headers
  end

  def json_request(method, url, body \\ "", headers \\ []) do
    if String.first(body) do
      HTTPotion.request(method, url, [body: JSX.encode!(body), headers: headers])
    else
      HTTPotion.request(method, url, [headers: headers])
    end
  end

  def build_url(url, params = []) do
    url
  end

  def build_url(url, params) do
    base = "#{url}?"
    params = Enum.map(params, fn(p) ->
      {k, v} = p
      "#{Atom.to_string(k)}=#{v}"
    end) |> Enum.join("&")
    base <> params |> URI.encode
  end
end
