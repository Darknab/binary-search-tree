require_relative 'merge-sort.rb'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

sorted_arr = merge_sort(arr).uniq

class Node
  attr_reader :value
  attr_accessor :left_child, :right_child
  
  def initialize(value = nil, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end
  
end

class Tree
  attr_accessor :arr, :root

  def initialize(arr)
    @arr = arr
    @root = build_tree(arr)
  end

  def build_tree(arr = @arr)
    return Node.new(arr[0]) if arr.length == 1
  
    mid = (arr.length / 2).to_i
    root = Node.new(arr[mid])
    left_arr = arr[0..(mid - 1)]
    right_arr = arr[(mid + 1)..(arr.length - 1)]
    root.left_child = build_tree(left_arr) if left_arr.length != 0
    root.right_child = build_tree(right_arr) if right_arr.length != 0

    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(element, root = @root)
    #return "#{element} is already in the list!" if self.contains?(element) 
    if element > root.value
      if root.right_child
        insert(element, root.right_child)
      else
        root.right_child = Node.new(element)
        puts "#{element} was successfully added to the tree!"
        return
      end
    elsif element < root.value
      if root.left_child
        insert(element, root.left_child)
      else
        root.left_child = Node.new(element)
        puts "#{element} was successfully added to the tree!"
        return
      end
    else puts "#{element} is already in the list!"
    end
  end

  def remove(element)
    
  end


end

tree = Tree.new(sorted_arr)

tree.pretty_print

tree.insert(5)

tree.pretty_print
