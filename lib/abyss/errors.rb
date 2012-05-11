module Abyss

  module Errors

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
