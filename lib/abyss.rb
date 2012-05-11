require "abyss/version"
require "abyss/errors"
require "abyss/deep_store"
require "abyss/store"

module Abyss

  class << self
    attr_accessor :configuration
  end

  # Public interface to Abyss Configuragion API
  # See Store for examples.
  #
  def self.configure(&block)
    self.configuration ||= Store.new
    self.configuration.instance_eval &block
  end

end
