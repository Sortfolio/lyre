require 'sinatra/base'
require 'capybara'

module Lyre

  #NOTE: Not sure this is the right name for this class
  class App < Sinatra::Base

    attr_accessor :endpoint

    class << self
      attr_accessor :setup_block, :teardown_block

      def setup(&block)
        self.setup_block = block
      end

      def teardown(&block)
        self.teardown_block = block
      end

      def boot
        instance = self.new! #maybe just new

        Capybara::Server.new(instance).tap do |server|
          server.boot

          instance.endpoint = "http://#{server.host}:#{server.port}"
          
          setup_block.call(instance) if setup_block
        end

        instance
      end
    end

    def shutdown
      self.class.teardown_block.call(self) if self.class.teardown_block
    end

  end

end