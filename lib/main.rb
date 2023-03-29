require 'pry-byebug'
require_relative 'merge-sort.rb'
require_relative 'node.rb' 
require_relative 'tree.rb'

arr = Array.new(15) {rand(1..100)}

sorted_arr = merge_sort(arr).uniq
def max(a, b)
  if a > b
    a
  else
    b
  end
end


tree = Tree.new(sorted_arr)

tree.pretty_print


if tree.balanced?
  puts "The tree is balanced"
else
  puts "The tree is not balanced"
end

puts "Elements in level-order:"
p tree.level_order

puts "Elements in inorder:"
p tree.inorder

puts "Elements in preorder:"
p tree.preorder

puts "elements in postorder"
p tree.postorder

10.times do 
tree.insert(rand(100..1000))
end

tree.pretty_print


if tree.balanced?
  puts "The tree is balanced"
else
  puts "The tree is not balanced"
end

tree.rebalance
puts "The tree is now rebalanced:"
tree.pretty_print

puts "Elements in level-order:"
p tree.level_order

puts "Elements in inorder:"
p tree.inorder

puts "Elements in preorder:"
p tree.preorder

puts "elements in postorder"
p tree.postorder


