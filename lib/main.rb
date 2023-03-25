require_relative 'merge-sort.rb'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

sorted_arr = merge_sort(arr).uniq

p sorted_arr