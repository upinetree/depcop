require "minitest/autorun"
require "depcop"

class TestEfferentCouplings < MiniTest::Test
  def test_showing_efferent_couplings
    nodes = [["A"], ["A", "B"], ["C"], ["D"], ["Source"]]
    edges = [
      { "from" => ["Source"], "to" => ["A::B"] },
      { "from" => ["Source"], "to" => ["C"] },
      { "from" => ["Source"], "to" => ["D"] },
      { "from" => ["D"], "to" => ["C"] },
    ]
    edges_over_max = edges + [
      { "from" => ["Source"], "to" => ["A"] },
    ]
    config = { "Max" => 3 }

    warnings = Depcop::Rule::EfferentCouplings.new(nodes, edges, config).run
    assert_equal 0, warnings.size

    warnings = Depcop::Rule::EfferentCouplings.new(nodes, edges_over_max, config).run
    assert_equal 1, warnings.size
  end
end
