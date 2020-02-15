require_relative "depcop/rule"
require_relative "depcop/version"

require "json"

module Depcop
  class Cli
    def self.run(json_string)
      dependency_graph = JSON.parse(json_string)
      warnings = Rule::CircularDependency.new(dependency_graph["nodes"], dependency_graph["edges"]).run
      puts warnings.join("\n")
    end
  end
end
