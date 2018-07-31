defmodule SimpleFormats do

  def format_response do
    format_headers <> "\n" <> format_body
  end

  defp format_headers do
    """
    HTTP/1.1 200 OK
    Date: #{:httpd_util.rfc1123_date}
    Content-Type: text/plain
    Content-Length: 12
    """
  end

  defp format_body do
     """
      Here is your response from the server!
    """
  end
end
