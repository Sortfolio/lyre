require 'lyre/registry'
require 'sinatra'

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

      alias_method :create, :new! #Sinatra redefines new as new!, so make it easy to access
    end

    def start
      Lyre::Registry.register_and_run self
      self.instance_eval(&self.class.setup_block) if self.class.setup_block
      self
    end

    def stop
      Lyre::Registry.stop_and_deregister self
      self.instance_eval(&self.class.teardown_block) if self.class.teardown_block
      self
    end

    def endpoint
      "http://#{host}:#{port}" #may want to make http/https configurable
    end
  end

end