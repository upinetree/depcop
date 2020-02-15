module Depcop
  module Rule
    class EfferentCouplings
      CONFIG_DEFAULTS = { "Max" => 5 }

      def initialize(nodes, edges, config)
        efferent_deps = Hash[nodes.map { |n| [n.join("::"), []] }]

        edges.each do |edge|
          to = edge["to"].join("::")
          from = edge["from"].join("::")
          efferent_deps[from] << to
        end

        @efferent_deps = efferent_deps
        @config = CONFIG_DEFAULTS.merge(config || {})
      end

      def run
        @efferent_deps.select { |_from, to|
          to.size > @config["Max"]
        }.map { |from, to|
          "Efferent couplings (Ce) too high [#{to.size}/#{@config["Max"]}]: #{from}"
        }
      end
    end
  end
end
