defmodule SimpleFormats do

  def format_response(response) do
    format_headers(response) <> "\n" <> format_body(response)
  end

  defp format_headers(response) do
    """
    HTTP/1.1 200 OK
    Date: #{:httpd_util.rfc1123_date}
    Content-Type: text/plain
    Content-Length: #{length(response)}
    """
  end

  defp format_body(response) do
     """
      Here is your response from the server: #{response}!
    """
  end
end
