# Given this data structure write some code to return an array containing the colors of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# The return value should look like this:
[["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

# my_answer =>
# how to get nested values
hsh['grape'][:colors][0]
hsh['grape'][:colors][1]
hsh['carrot'][:size]

# mental model
# iterate though each key in the hash
# determine if it is a fruit or vegetable
# if fruit select the colors key and return values
# if vegetable select the size key and return the value
# take colors values and iterate though the array captializing each word
# take the size value and upcase
# return new array

# code with intent
 new_array = hsh.map do |_, value|
          if value[:type] == 'fruit'
            value[:colors].map do |color|
              color.capitalize
            end
          else
            value[:size].upcase
          end
        end
p new_array


# example_of_answer =>
hsh.map do |_, value|
  if value[:type] == 'fruit'
    value[:colors].map do |color|
      color.capitalize
    end
  elsif value[:type] == 'vegetable'
    value[:size].upcase
  end
end

