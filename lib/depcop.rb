require_relative "depcop/rule"
require_relative "depcop/version"

require "json"

module Depcop
  class Cli
    def self.run(json_str, config = {})
      nodes, edges = JSON.parse(json_str).values_at("nodes", "edges")

      warnings = rules.map do |rule|
        demodulized_rule_name = rule.name.split("::").last
        rule.new(nodes, edges, config[demodulized_rule_name]).run
      end

      puts warnings.flatten.join("\n")
    end

    # TODO: Add a rule to this list when inherited base class of the rules
    def self.rules
      [Rule::CircularDependency, Rule::AfferentCouplings, Rule::EfferentCouplings]
    end
  end
end
