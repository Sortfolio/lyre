require 'sinatra/base'
require 'capybara'
require 'rack/handler/thin'

module Lyre

  #NOTE: Not sure this is the right name for this class
  class App < Sinatra::Base

    attr_accessor :host, :port

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

        instance.startup

        instance
      end
    end

    def startup
      with_thin_runner do
        Capybara::Server.new(self).tap do |server|
          server.boot

          self.host = server.host
          self.port = server.port
        
          self.class.setup_block.call(self) if self.class.setup_block
        end
      end
    end

    def shutdown
      self.class.teardown_block.call(self) if self.class.teardown_block
    end

    def endpoint
      "http://#{host}:#{port}"
    end

    private

    def with_thin_runner
      default_server_process = Capybara.server
      Capybara.server do |app, port|
        Rack::Handler::Thin.run(app, :Port => port)
      end
      yield
    ensure
      Capybara.server(&default_server_process)
    end
  end

end