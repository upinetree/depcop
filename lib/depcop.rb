require_relative "depcop/rule"
require_relative "depcop/version"

require "json"

module Depcop
  class Cli
    def self.run(json_str)
      nodes, edges = JSON.parse(json_str).values_at("nodes", "edges")

      warnings = rules.map do |rule|
        rule.new(nodes, edges).run
      end

      puts warnings.flatten.join("\n")
    end

    # TODO: Add a rule to this list when inherited base class of the rules
    def self.rules
      [Rule::CircularDependency, Rule::AfferentCouplings]
    end
  end
end
