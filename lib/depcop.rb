require "depcop/version"

require "json"
require "tsort"

module Depcop
  class Cli
    def self.run(json_string)
      dependency_graph = JSON.parse(json_string)
      warnings = CircularDependency.new(dependency_graph["nodes"], dependency_graph["edges"]).run
      puts warnings.join("\n")
    end
  end

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
