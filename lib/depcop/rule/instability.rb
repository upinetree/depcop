module Depcop
  module Rule
    class Instability
      # TODO: Support an afferent coupling threshold to adjust sensitiveness
      CONFIG_DEFAULTS = { "Max" => 0.5 }

      def initialize(nodes, edges, config)
        couplings = Hash[nodes.map { |n| [n.join("::"), { in: [], out: [] }] }]

        # {
        #   "A": {
        #     in: ["B"],
        #     out: ["C", "D", "E"],
        #   },
        # }
        edges.each do |edge|
          to = edge["to"].join("::")
          from = edge["from"].join("::")
          couplings[from][:out] << to
          couplings[to][:in] << from
        end

        @couplings = couplings
        @config = CONFIG_DEFAULTS.merge(config || {})
      end

      def run
        instabilities = {}
        @couplings.each { |node, coupling|
          sum = coupling[:out].size + coupling[:in].size
          next if sum.zero?
          instabilities[node] = coupling[:out].size.to_r / sum
        }

        instabilities.select { |_node, instability|
          instability > @config["Max"]
        }.map { |node, instability|
          instability_str = "%.2f" % instability.to_f
          "Instability (I) too high [#{instability_str}/#{@config["Max"]}]: #{node}"
        }
      end
    end
  end
end
