require 'capybara'

module Lyre
  module Registry

    @@registry = {}

    def self.register_and_run(lyre)
      raise "Lyre already registered" if @@registry.has_key? lyre.class

      @@registry[lyre.class] = Capybara::Server.new(lyre).tap do |server|
        server.boot

        lyre.host = server.host
        lyre.port = server.port
      end
    end

    def self.stop_and_deregister(lyre)
      raise "Lyre not registered" unless @@registry.has_key? lyre.class

      #server cannot be stopped

      @@registry.delete(lyre.class)
    end
  end
end