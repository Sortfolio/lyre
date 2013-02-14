require 'capybara'

module Lyre
  module Registry

    @@registry = {}

    def self.register_and_run(lyre)
      raise "Lyre already registered" if @@registry.has_key? lyre

      @@registry[lyre] = Capybara::Server.new(lyre).tap do |server|
        server.boot

        lyre.host = server.host
        lyre.port = server.port
      end
    end

    def self.stop_and_deregister(lyre)
      raise "Lyre not registered" unless @@registry.has_key? lyre

      #there is no way to stop a Capybara server, so nothing to stop

      @@registry.delete(lyre)
    end
  end
end