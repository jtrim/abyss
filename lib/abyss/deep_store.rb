require 'active_support/ordered_hash'

module Abyss

  # = DeepStore
  # === Abstract Class
  #
  # An object meant for configuration that allows arbitrary configuration
  # properties and arbitrarily deep configuration groups.
  #
  # Meant to be subclassed. The power of this class lies in the 'assign'
  # method.
  #
  # Examples:
  #
  #     class MyConfig < DeepStore
  #
  #       def assign(property_name, values)
  #         # values is an array of the arguments picked up by #method_missing
  #         self.configurations[property_name] = manipulate(values)
  #       end
  #
  #       private
  #
  #       def manipulate(values)
  #         # something important...
  #         values
  #       end
  #
  #     end
  #
  #     my_config = MyConfig.new
  #     my_config.my_config_group do # arbitrary configuration group
  #       my_configuration_property "Hardy har!", "Grumblegrumblegrumble..." # configuration item, also arbitrary
  #     end
  #
  #     my_config.my_config_group.my_configuration_property #=> [ "Hardy har!", "Grumblegrumblegrumble..." ]
  #
  class DeepStore

    attr_accessor :configurations, :name

    def initialize(name=nil) #:nodoc:
      @configurations = ActiveSupport::OrderedHash.new {}
      @name = name
    end

    # If a block is passed, add a configuration group named `method_name`
    # (which is just a new instance of DeepStore) and evaluate the block
    # against the new instance.
    #
    # If one or more arguments are supplied, calls `#assign(method_name, args)
    #
    # If no arguments are supplied, return the entity stored by `method_name`.
    # Could be a DeepStore instance or some arbitrary configuration.
    #
    def method_missing(method_name, *args, &block)

      # TODO: document the block + arguments scenario when subclassing
      if block_given?
        @configurations[method_name] ||= self.class.new(*args.unshift(method_name))
        @configurations[method_name].instance_eval &block
        return @configurations[method_name]
      end

      return get(method_name) if args.length == 0

      assign(method_name, args)
    end

    # Abstract method. Override this in a subclass to do processing on the
    # config name / value to be stored.
    #
    def assign(name, values)
      raise Errors::AbstractMethod.new("#assign")
    end

    def get(method_name) #:nodoc:
      @configurations[method_name]
    end

  end

end
