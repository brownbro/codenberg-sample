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

  def create_order(template_id, postal_code, pref, city, address_line1, name, tel, custom_fields)
    @conn.post do |req|
      req.url 'orders'
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        :access_token => @access_token,
        :template_id => template_id,
        :confirmation => "false",
        :postal_code => postal_code,
        :pref => pref,
        :city => city,
        :address_line1 => address_line1,
        :name => name,
        :tel => tel,
        :custom_fields => custom_fields
      }.to_json
    end
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
