require 'net/http'
require 'json'

class Google
  API_URL = "https://www.googleapis.com"

  def get_books_by_name(name, offset=0)
    books = make_get_request "/books/v1/volumes", { q: name, startIndex: offset }
    if books && books.has_key?('items')
      books['items'] 
    else 
      nil
    end

  end

  def make_get_request(hook, params={})
    uri = URI(API_URL + hook)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else 
      nil
    end
  end
end