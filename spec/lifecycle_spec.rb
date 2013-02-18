require 'spec_helper'

describe "Lifecycle Tests" do

  describe "setup and teardown are called" do
    before(:each) { @lyre = LifeCycleLyre.boot }
    after(:each) { @lyre.shutdown }

    it "should call setup block when the lyre is started" do
      LifeCycleLyre.setup_called.should be_true
    end

    it "should call teardown block when the lyre is stopped" do
      @lyre.shutdown

      LifeCycleLyre.setup_called.should be_true   
    end
  end

  describe "setup and teardown are optional" do
    it "should not fail if the lyre has no setup" do
      NoLifeCycleLyre.boot
    end

    it "should not fail of the lyre has no teardown" do
      NoLifeCycleLyre.boot.shutdown
    end
  end

end