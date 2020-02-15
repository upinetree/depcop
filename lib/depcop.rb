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

    def self.rules
      [Rule::CircularDependency]
    end
  end
end
