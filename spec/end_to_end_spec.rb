require 'spec_helper'

describe 'End to end test - Refactor later' do
  
  before(:all) do
    @lyre = FakeServiceLyre.create.start
  end

  after(:all) do
    @lyre.stop
  end

  it "should mock the endpoint that FakeService tries to access" do
    FakeService.call_service.should == 'Hello World'
  end

end