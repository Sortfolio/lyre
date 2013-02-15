class LifeCycleLyre < Lyre::App

  setup do
    LifeCycleLyre.setup_called = true
  end

  teardown do
    LifeCycleLyre.teardown_called = true
  end

  def self.setup_called
    @@setup_called
  end

  def self.setup_called=(value)
    @@setup_called = value
  end

  def self.teardown_called
    @@teardown_called
  end

  def self.teardown_called=(value)
    @@teardown_called = value
  end

end