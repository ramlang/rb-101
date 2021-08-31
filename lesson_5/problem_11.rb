# Given the following data structure use a combination of methods, including either the select or reject method, to return a new array identical in structure to the original but containing only the integers that are multiples of 3.
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

# my_answer =>
new_arr = arr.map do |array|
            multiples = []
            array.select do |num|
              multiples << num if num % 3 == 0
            end
            multiples
          end

p new_arr

# do not need to use a variable array to store an array because the values from both methods return arrays. In the previous problem the variable was needed because the return value needed to be a hash. Select will return an array and map will return an array of the arrays from select.


# correct_answer =>
arr.map do |element|
  element.select do |num|
    num % 3 == 0
  end
end
# => [[], [3], [9], [15]]