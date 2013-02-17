class FakeServiceLyre < Lyre::App

  setup do |lyre|
    @original_endpoint = FakeService.endpoint
    FakeService.endpoint = lyre.endpoint
  end

  teardown do |lyre|
    FakeService.endpoint = @original_endpoint
  end

  get '/' do
    'Hello World'
  end

end