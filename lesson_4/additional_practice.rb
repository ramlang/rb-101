flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# Turn this array into a hash where the names are the keys and the values are the positions in the array.

# my_answer =>
counter = 0
array = flintstones.each_with_object({}) do |value, hash|
  hash[value] = counter
  counter += 1
end

# correct_answer =>
flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

# ----------

# Add up all of the ages from the Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# my_answer =>
puts ages.values.sum

# example_of_answer =>
total_ages = 0
ages.each { |_,age| total_ages += age }
total_ages # => 6174

# example_of_answer =>
ages.values.inject(:+) # => 6174

# ----------

#In the age hash remove people with age 100 and greater:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# my_answer =>
ages.each do |key, value|
  ages.delete(key) if value >= 100
end

# correct_answer =>
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.keep_if { |_, age| age < 100 }

# alternative_answer =>
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.select! do |_, age|
  age <= 100
end

# ----------

# Pick out the minimum age from our current Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

#my_answer =>
ages.values.min

# ----------


# Find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# my_answer =>
flintstones.each_with_index { |value, ind| puts ind if value.include?("Be") }

# example_of_answer =>
flintstones.index { |name| name[0, 2] == "Be" }

# ----------

# Amend this array so that the names are all shortened to just the first three characters:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# my_answer =>
flintstones.map! do |name|
  name[0,3]
end

# example_of_answer =>
flintstones.map! { |name| name[0,3] }

# ----------

# Create a hash that expresses the frequency with which each letter occurs in this string:
statement = "The Flintstones Rock"

# example 
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

statement.delete(' ').chars.each_with_object({}) { |letter, hash|
  hash[letter] = statement.count(letter)
}

# example_of_answer =>
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

# ----------

# What happens when we modify an array while we are iterating over it? What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# my_answer =>
# When we modify an array while iterating over it, the array object is affected. In this case the first element is removed and the rest of the array remains as numbers.
# The output would be:
# 1234

# correct_answer =>
1
3
# The counter for each does not start over, so once it has iterated and removed at index 0, it goes onto index 1 at which point the array [2, 3, 4] is remaining. Thus 3 is outputted and because another element will be removed, an index 2 will not exist in [3, 4] array.

# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# my_answer =>
# 12

# correct_answer =>
1
2

# ----------

# As we have seen previously we can use some built-in string methods to change the case of a string. A notably missing method is something provided in Rails, but not in Ruby itself...titleize. This method in Ruby on Rails creates a string that has each word capitalized as it would be in a title. For example, the string:
words = "the flintstones rock"

# would be:
words = "The Flintstones Rock"

# Write your own version of the rails titleize implementation.

# my_answer =>
words.split.map! { |word| word.capitalize! }.join(' ')

# ---------

# Given the munsters hash below
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below
{ "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }
  
# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

# my_answer =>
munsters.each do |key, value|
  if (0..17).include?(munsters[key]["age"])
    munsters[key]["age_group"] = "kid"
  elsif (18..64).include?(munsters[key]["age"])
    munsters[key]["age_group"] = "adult"
  else (munsters[key]["age"]) > 65
    munsters[key]["age_group"] = "senior"
  end
end

# correct_answer =>
munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end

