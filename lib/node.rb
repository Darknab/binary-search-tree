class Node
  attr_accessor :left_child, :right_child, :parent, :value

  def initialize(value = nil, left_child = nil, right_child = nil, parent = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
    @parent = parent
  end
end
