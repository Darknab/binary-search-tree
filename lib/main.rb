require 'pry-byebug'
require_relative 'merge-sort.rb'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

sorted_arr = merge_sort(arr).uniq

class Node
  #attr_reader :value
  attr_accessor :left_child, :right_child, :parent, :value
  
  def initialize(value = nil, left_child = nil, right_child = nil, parent = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
    @parent = parent
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
    if left_arr.length != 0
      root.left_child = build_tree(left_arr) 
      root.left_child.parent = root
    end
    if right_arr.length != 0
      root.right_child = build_tree(right_arr) 
      root.right_child.parent = root
    end

    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(element, root = @root)
    if element > root.value
      if root.right_child
        insert(element, root.right_child)
      else
        root.right_child = Node.new(element)
        root.right_child.parent = root
        puts "#{element} was successfully added to the tree!"
        return
      end
    elsif element < root.value
      if root.left_child
        insert(element, root.left_child)
      else
        root.left_child = Node.new(element)
        root.left_child.parent = root
        puts "#{element} was successfully added to the tree!"
        return
      end
    else puts "#{element} is already in the list!"
    end
  end

  def find(element, node = @root)
    return false if !node
    if element == node.value
      return node
    elsif element > node.value
      if root.right_child
        find(element, node.right_child)
      else return false
      end
    else 
      if root.left_child
        find(element, node.left_child)
      else return false
      end
    end
  end

  def delete(element)
    if !self.find(element)
      puts "#{element} is not in the tree"
      return
    else node = self.find(element)
    end
    parent = node.parent
    #binding.pry
    if !node.right_child && !node.left_child
      parent.left_child = nil if parent.value > node.value
      parent.right_child = nil if parent.value < node.value
    elsif !node.right_child && node.left_child
      parent.left_child = node.left_child if parent.value > node.value
      parent.right_child = node.left_child if parent.value < node.value
    elsif node.right_child && !node.left_child
      parent.left_child = node.right_child if parent.value > node.value
      parent.right_child = node.right_child if parent.value < node.value
    else
      minimum = self.minimum_node(node.right_child)
      self.delete(minimum.value)
      node.value = minimum.value
    end


  end

  private

  def minimum_node(node = @root)
    if node.left_child
      minimum_node(node.left_child)
    else return node
    end
  end
end

tree = Tree.new(sorted_arr)

tree.pretty_print


tree.delete(8)

tree.pretty_print


