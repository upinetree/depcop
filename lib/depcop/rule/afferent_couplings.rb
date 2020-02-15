module Depcop
  module Rule
    class AfferentCouplings
      CONFIG_DEFAULTS = { max: 5 }

      def initialize(nodes, edges, config)
        afferent_deps = Hash[nodes.map { |n| [n.join("::"), []] }]

        edges.each do |edge|
          to = edge["to"].join("::")
          from = edge["from"].join("::")
          afferent_deps[to] << from
        end

        @afferent_deps = afferent_deps
        @config = CONFIG_DEFAULTS.merge(config || {})
      end

      def run
        @afferent_deps.select { |_to, from|
          from.size > @config["Max"]
        }.map { |to, from|
          "Afferent couplings too high [#{from.size}/#{@config["Max"]}]: #{to}"
        }
      end
    end
  end
end
