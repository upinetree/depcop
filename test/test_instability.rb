require "minitest/autorun"
require "depcop"

class TestInstability < MiniTest::Test
  def test_showing_instability
    nodes = [["A"], ["A", "B"], ["C"], ["D"], ["E"]]
    edges = [
      # Adjust instability of A to be 2/(2+1) => 0.667
      { "from" => ["A"], "to" => ["A", "B"] },
      { "from" => ["A"], "to" => ["C"] },
      { "from" => ["D"], "to" => ["A"] },
      # Adjust instability of other nodes to be 0.5
      { "from" => ["C"], "to" => ["D"] },
      { "from" => ["A", "B"], "to" => ["E"] },
    ]
    edges_over_max = edges + [
      # Instability of A becomes 3/(3+1) => 0.75
      { "from" => ["A"], "to" => ["D"] },
    ]
    config = { "Max" => 0.74 }

    warnings = Depcop::Rule::Instability.new(nodes, edges, config).run
    assert_equal 0, warnings.size

    warnings = Depcop::Rule::Instability.new(nodes, edges_over_max, config).run
    assert_equal 1, warnings.size
    assert_match "Instability (I) too high [0.75/0.74]: A", warnings.first
  end
end
