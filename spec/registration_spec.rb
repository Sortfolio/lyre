require 'spec_helper'

describe "Lyre registration" do

  before(:each) do
    @lyre_one = FakeServiceLyre.create
    @lyre_two = FakeServiceLyre.create
  end

  after(:each) do
    @lyre_one.stop
    @lyre_two.stop
  end

  it "should not allow two instances of the same lyre to run simultaneously" do
    @lyre_one.start
    expect { @lyre_two.start }.to raise_error('Lyre already registered')
  end

end