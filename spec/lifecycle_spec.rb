require 'spec_helper'

describe "Lifecycle Tests" do

  describe "setup and teardown are called" do
    it "should call setup block when the lyre is started" do
      lyre = LifeCycleLyre.create
      lyre.start

      LifeCycleLyre.setup_called.should be_true
    end

    it "should call teardown block when the lyre is stopped" do
      lyre = LifeCycleLyre.create
      lyre.start
      lyre.stop

      LifeCycleLyre.setup_called.should be_true   
    end
  end

  describe "setup and teardown are optional" do
    it "should not fail if the lyre has no setup" do
      NoLifeCycleLyre.create.start
    end

    it "should not fail of the lyre has no teardown" do
      NoLifeCycleLyre.create.start.stop
    end
  end

end