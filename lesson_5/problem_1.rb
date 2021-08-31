# How would you order this array of number strings by descending numeric value?
arr = ['10', '11', '9', '7', '8']

# my_answer =>
arr.sort { |a, b| b.to_i <=> a.to_i }

# example_of_answer =>
arr.sort do |a,b|
  b.to_i <=> a.to_i
end
# => ["11", "10", "9", "8", "7"]