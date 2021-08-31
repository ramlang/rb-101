# Given the following data structure and without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.
array = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# my_answer =>
new_array = array.map do |hash|
  hash.map { |k, v| [k, v + 1] }.to_h
end

p array
p new_array


# example_of_answer =>
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end
# => [{:a=>2}, {:b=>3, :c=>4}, {:d=>5, :e=>6, :f=>7}]