require 'spec_helper'

describe FakeService do
  it "should return an empty string when default values are used" do
    expect { FakeService.call_service }.to raise_error(SocketError, 'getaddrinfo: nodename nor servname provided, or not known')
  end
end
