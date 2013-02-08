require 'net/http'

class FakeService

  class << self
    def endpoint
      @endpoint || 'example.com'
    end

    def endpoint=(value)
      @endpoint = value
    end

    def call_service
      http = Net::HTTP.new(endpoint)
      request = Net::HTTP::Get.new("/")
      response = http.request(request)

      response.body
    end
  end

end
