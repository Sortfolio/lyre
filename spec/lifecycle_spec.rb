require 'spec_helper'

describe "Lifecycle Tests" do

  describe "setup and teardown are called" do
    before(:each) { @lyre = LifeCycleLyre.create.start }
    after(:each) { @lyre.stop }

    it "should call setup block when the lyre is started" do
      LifeCycleLyre.setup_called.should be_true
    end

    it "should call teardown block when the lyre is stopped" do
      @lyre.stop

      LifeCycleLyre.setup_called.should be_true   
    end
  end

  describe "setup and teardown are optional" do
    before(:each) { @lyre = NoLifeCycleLyre.create }
    after(:each) { @lyre.stop }

    it "should not fail if the lyre has no setup" do
      @lyre.start
    end

    it "should not fail of the lyre has no teardown" do
      @lyre.stop
    end
  end

  describe "start and stop are idempotent" do
    before(:each) { @lyre = NoLifeCycleLyre.create }
    after(:each) { @lyre.stop }

    it "should allow start to be called twice" do
      @lyre.start.start
    end

    it "should allow stop to be called twice" do
      @lyre.start.stop.stop
    end

  end

end