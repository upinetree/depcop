require "tsort"

module Depcop
  module Rule
    class CircularDependency
      def initialize(nodes, edges)
        dependencies = Hash[nodes.map { |n| [n.join("::"), []] }]

        edges.each do |edge|
          node = edge["from"].join("::")
          dependency = edge["to"].join("::")
          dependencies[node] << dependency
        end

        @graph = Graph.new(dependencies)
      end

      def run
        circles = @graph.strongly_connected_components.select { |component| component.size > 1 }
        circles.map { |c| "Circular dependency: " + c.join(" --- ") }
      end

      class Graph
        include TSort

        def initialize(dependencies)
          @dependencies = dependencies
        end

        def tsort_each_node(&block)
          @dependencies.each_key(&block)
        end

        def tsort_each_child(node, &block)
          @dependencies[node].each(&block)
        end
      end
    end
  end
end
