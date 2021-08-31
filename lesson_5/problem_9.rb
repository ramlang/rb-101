# Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# my_answer =>
new_arr = arr.map do |array|
            array.sort do |a, b|
              b <=> a
            end
          end

p new_arr