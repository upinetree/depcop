require "minitest/autorun"
require "depcop"

class TestAfferentCouplings < MiniTest::Test
  def test_showing_afferent_couplings
    nodes = [["A"], ["A", "B"], ["C"], ["D"], ["Target"]]
    edges = [
      { "from" => ["A::B"], "to" => ["Target"] },
      { "from" => ["C"], "to" => ["Target"] },
      { "from" => ["D"], "to" => ["Target"] },
      { "from" => ["Target"], "to" => ["A"] },
    ]
    edges_over_max = edges + [
      { "from" => ["A"], "to" => ["Target"] },
    ]
    config = { "Max" => 3 }

    warnings = Depcop::Rule::AfferentCouplings.new(nodes, edges, config).run
    assert_equal 0, warnings.size

    warnings = Depcop::Rule::AfferentCouplings.new(nodes, edges_over_max, config).run
    assert_equal 1, warnings.size
  end
end
