module Abyss

  # = Store
  #
  # Utility for Abyss configuration.
  # Intended for use within a host app's initializer, eg:
  # /config/initializers/foundation.rb
  #
  # Examples:
  #
  #     Abyss.configure do
  #       title 'Abyss Demo'
  #
  #       backend do
  #         support do
  #           email 'info@factorylabs.com'
  #           phone '303-555-1234'
  #         end
  #       end
  #
  #     end
  #
  class Store < DeepStore

    # Overrides DeepStore#assign. Simply assigns the configuration name to the
    # first value.
    #
    def assign(name, values)
      self.configurations[name] = values.first
    end

  end

end
