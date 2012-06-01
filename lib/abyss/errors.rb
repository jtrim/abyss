module Abyss

  module Errors

    class NotFound < RuntimeError
      attr_accessor :path

      def initialize(path)
        self.path = path
      end

      def message
        "Value at '#{path}' not found."
      end
    end

    class AbstractMethod < RuntimeError
      attr_accessor :name

      def initialize(name)
        self.name = name
      end

      def message
        "Abstract method: must override #{name} in a base class."
      end
    end

  end

end
