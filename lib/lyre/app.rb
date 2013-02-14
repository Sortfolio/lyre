require 'lyre/registry'
require 'sinatra'

module Lyre

  #NOTE: Not sure this is the right name for this class
  class App < Sinatra::Base

    def self.setup(&block)
      @@setup_block = block
    end

    def self.teardown(&block)
      @@teardown_block = block
    end

    def self.create
      self.new! #Sinatra redefines new as new!
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

    def host
      @host
    end

    def host=(value)
      @host = value
    end

    def port
      @port
    end

    def port=(value)
      @port = value
    end

    def endpoint
      "http://#{host}:#{port}" #may want to make http/https configurable
    end
  end

end