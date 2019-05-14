defmodule OnesignalElixir.API do
    
	def post(url,body, headers, _options \\ []) do
		body = Poison.encode!(body)
        HTTPoison.post!(url, body, headers)
        |> handle_response
	end

    defp handle_response(%HTTPoison.Response{body: body, status_code: code}) when code in 200..299 do
        {:ok, Poison.decode!(body)}
    end

    defp handle_response(%HTTPoison.Response{body: body, status_code: _}) do
        {:error, Poison.decode!(body)}
    end
    
end