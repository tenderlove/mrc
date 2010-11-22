module MRC
  module Visitors
    class Interpreter
      def initialize delegate
        @delegate = delegate
      end

      def accept node
        send("visit_#{node.class.name.gsub('::', '_')}", node)
      end

      def visit_MRC_Mustache o
        name, params = o.children
        name         = accept name
        params       = params.map { |param| accept param }
        @delegate.send(name, *params)
      end

      def visit_MRC_Id o
        o.name.to_sym
      end

      def visit_MRC_String o
        o.value
      end
    end
  end
end
