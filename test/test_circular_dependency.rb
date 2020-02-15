require "minitest/autorun"
require "depcop"

class TestCircularDependency < MiniTest::Test
  def test_showing_circles
    nodes = [["A"], ["A", "B"], ["C"], ["D"]]
    edges = [
      { "from" => ["A"], "to" => ["A", "B"] },
      { "from" => ["C"], "to" => ["D"] },
      { "from" => ["D"], "to" => ["A"] },
    ]
    cyclic_edges = edges + [
      { "from" => ["A"], "to" => ["C"] },
    ]

    warnings = Depcop::Rule::CircularDependency.new(nodes, edges).run
    assert_equal 0, warnings.size

    warnings = Depcop::Rule::CircularDependency.new(nodes, cyclic_edges).run
    assert_equal 1, warnings.size
  end
end
