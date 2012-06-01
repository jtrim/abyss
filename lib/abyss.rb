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
  #     Abyss.configure do
  #       three do
  #         levels do
  #           deep do
  #             day "Monday"
  #           end
  #         end
  #       end
  #     end
  #
  #     Abyss.has?("three/levels/deep/day") #=> true
  #     Abyss.has?("non/existent/thing")    #=> false
  #
  def self.has?(path)
    get(path) ? true : false
  end

  # Gets a value at a given configuration path, slash-separated
  #
  # Returns: Target value or nil
  #
  # Examples:
  #
  #     Abyss.configure do
  #       three do
  #         levels do
  #           deep do
  #             day "Monday"
  #           end
  #         end
  #       end
  #     end
  #
  #     Abyss.get("three/levels/deep/day") #=> "Monday"
  #     Abyss.has("non/existent/thing")    #=> nil
  #
  def self.get(path)
    path.split('/').inject(Abyss.configuration) do |acc, current_path_item|
      begin
        target = acc.send(current_path_item)
        return nil if target.nil?
      rescue NoMethodError
        return nil
      end
      target
    end
  end

  # Gets a value at a given configuration path, slash-separated. This version
  # raises an error if the value isn't defined.
  #
  # Returns: Target value
  #
  # Examples:
  #
  #     Abyss.configure do
  #       three do
  #         levels do
  #           deep do
  #             day "Monday"
  #           end
  #         end
  #       end
  #     end
  #
  #     Abyss.get("three/levels/deep/day") #=> "Monday"
  #     Abyss.has("non/existent/thing")    # Raises Abyss::Errors::NotFound
  #
  def self.get!(path)
    get(path) || raise(Abyss::Errors::NotFound.new(path))
  end

end
