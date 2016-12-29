require 'faraday'

class CodenbergClient
  def initialize(apikey, secret, url="https://api.codenberg.io/v1")
    @url = url
    @apikey = apikey
    @secret = secret
    @access_token, @expires = get_token

    @conn = Faraday.new(:url => @url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def show_templates
    response = @conn.get 'templates', {access_token: @access_token}
    puts response.body
  end

  private

  def get_token
    conn = Faraday.new(:url => @url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn.basic_auth(@apikey, @secret)
    response = conn.get 'auth/token'
    response_hash = JSON.parse response.body
    return response_hash["access_token"], response_hash["expires"]
  end
end
