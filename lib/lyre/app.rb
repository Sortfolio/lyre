require 'lyre/registry'
require 'sinatra'

module Lyre

  #NOTE: Not sure this is the right name for this class
  class App < Sinatra::Base

    attr_accessor :host, :port

    class << self
      def setup(&block)
        @@setup_block = block
      end

      def teardown(&block)
        @@teardown_block = block
      end

      alias_method :create, :new! #Sinatra redefines new as new!, so make it easy to access
    end

    def start
      Lyre::Registry.register_and_run self
      self.instance_eval(&@@setup_block)
      self
    end

    def stop
      Lyre::Registry.stop_and_deregister self
      self.instance_eval(&@@teardown_block)
      self
    end

    def endpoint
      "http://#{host}:#{port}" #may want to make http/https configurable
    end
  end

end