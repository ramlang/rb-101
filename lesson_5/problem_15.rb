# Given this data structure write some code to return an array which contains only the hashes where all the integers are even.
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# my_answer =>
# how to access nested array
p arr[0][:a]
p arr[1][:b]
p arr[1][:c]
p arr[1][:d]
p arr[2][:e]
p arr[2][:f]

# mental model
# iterate through array over hash elements
# within each hash iterate through the value (array)
# if all numbers are even return array
# return hash

new_array = arr.select do |sub_hash|
  sub_hash.values.all? do |array|
    array.all? { |num| num.even? }
  end
end

p new_array


# example_of_answer =>
arr.select do |hsh|
  hsh.all? do |_, value|
    value.all? do |num|
      num.even?
    end
  end
end
# => [{:e=>[8], :f=>[6, 10]}]