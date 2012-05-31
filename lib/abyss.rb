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

  # Check to see if a configuration has been defined.
  #
  # Examples:
  #
  # Abyss.configure do
  #   three do
  #     levels do
  #       deep do
  #         day "Monday"
  #       end
  #     end
  #   end
  # end
  #
  # Abyss.has?("three/levels/deep/day") #=> true
  # Abyss.has?("non/existent/thing")    #=> false
  #
  def self.has?(path)
    path.split('/').inject(Abyss.configuration) do |acc, current_path_item|
      begin
        target = acc.send(current_path_item)
      rescue NoMethodError
        return false
      end
      target
    end
    true
  end

end
