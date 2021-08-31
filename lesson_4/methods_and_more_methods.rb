# What is the return value of the select method below? Why?
[1, 2, 3].select do |num|
  num > 5
  'hi'
end

# my_answer =>
# [1, 2, 3] beause 'hi' is a truthy value and the block will return true for each iteration. This is a new array not the original array.

# -----------

# How does count treat the block's return value? How can we find out?
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

# my_answer =>
# counts the number of elements returning a true value when given a block, we can find out by looking at the ruby documentation

# example_of_answer =>
# Count considers the truthiness of the block's return value

# -----------

# What is the return value of reject in the following code? Why?
[1, 2, 3].reject do |num|
  puts num
end

# my_answer =>
# [1, 2, 3] because it returns a new array with values that are not true, and puts returns nil so every elememt in the array will be returned.

# -----------

# What is the return value of each_with_object in the following code? Why?
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

# my_answer =>
# {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'} because the value at index zero is the first letter of each element and it is being set to the actual value and forming a hash

# -----------

# What does shift do in the following code? How can we find out?
hash = { a: 'ant', b: 'bear' }
hash.shift

# my_answer =>
# shift removes and returns the first element of the collection, in this case a: 'ant', the original hash is mutated and will be left with b: 'bear' We can look at the ruby docs again. Returns removed values as a two item array [key, value]

# -----------

# What is the return value of the following statement? Why?
['ant', 'bear', 'caterpillar'].pop.size

# my_answer =>
# 11 because the Array#pop method returns and remvoes the last item of the array. The method #size is chained next so it will determine the size of the string 'caterpillar'

# -----------

# What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# my_answer =>
# true, false, true is the block's return value and it is determined by looking at each element and whether or not it returns true or false from the block. The return value of #any? is true and this code outputs:
# 1
# 2
# 3

# correct_answer =>
# The return value of the block is determined by the return value of the last expression within the block. In this case the last statement evaluated is num.odd?, which returns a boolean. Therefore the block's return value will be a boolean, since Integer#odd? can only return true or false.

# Since the Array#any? method returns true if the block ever returns a value other than false or nil, and the block returns true on the first iteration, we know that any? will return true. What is also interesting here is any? stops iterating after this point since there is no need to evaluate the remaining items in the array; therefore, puts num is only ever invoked for the first item in the array: 1

# -----------

# How does take work? Is it destructive? How can we find out?
arr = [1, 2, 3, 4, 5]
arr.take(2)

# my_answer =>
# take returns the first number(s) of elements from an array as a new array. It is not destructive, you can find out using irb or lookig at the documentation.

# -----------

# What is the return value of map in the following code? Why?
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# my_answer =>
# ['bear'] is the return value of map because it will return an array with the results from the block in this case it is the value being returned.

# correct_answer =>
# => [nil, "bear"]

# -----------

# What is the return value of the following code? Why?
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# my_answer =>
# [1, nil, nil] because puts will return nil when the value is greater than 1 and map always returns an array.
