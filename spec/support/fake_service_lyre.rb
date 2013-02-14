class FakeServiceLyre < Lyre::App

  setup do
    @original_endpoint = FakeService.endpoint
    FakeService.endpoint = endpoint
  end

  teardown do
    FakeService.endpoint = @original_endpoint
  end

  get '/' do
    'Hello World'
  end

end