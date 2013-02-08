require 'net/http'

class FakeService

  def self.endpoint
    @@endpoint || 'http://www.example.com'
  end

  def self.endpoint=(value)
    @@endpoint = value
  end

  def self.call_service
    http = Net::HTTP.new(self.endpoint)
    request = Net::HTTP::Get.new("/foo")
    response = http.request(request)
    response.body
  end
end
