def merge_sort(array)
  n = array.length
  if n < 2
    return  array
  else
    if n % 2 != 0
      half = (n - 1) / 2
    else half = n / 2
    end
    first_half = merge_sort(array.slice(0, half))
    second_half = merge_sort(array.slice(half, n + 1))
  result = []
  end
  loop do
    if !first_half || first_half.empty?
      result << second_half
      break
    elsif !second_half || second_half.empty?
      result << first_half 
      break
    end
    if first_half[0] < second_half[0]
      result << first_half[0]
      first_half.delete_at(0)
    else
      result << second_half[0]
      second_half.delete_at(0)
    end 
  end
  result.flatten
end