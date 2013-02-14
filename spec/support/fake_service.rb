require 'net/http'

class FakeService

  class << self
    def endpoint
      @endpoint || 'http://nowhere.example.com'
    end

    def endpoint=(value)
      @endpoint = value
    end

    def call_service
      url = URI.parse(endpoint)

      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Get.new("/")
      response = http.request(request)

      response.body
    end
  end

end
