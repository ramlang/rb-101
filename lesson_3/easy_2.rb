# Question 1
# In this hash of people and their age, see if "Spot" is present.
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# Bonus: What are two other hash methods that would work just as well for this
# solution

# my_answer =>
ages.include?("Spot")
ages.key?("Spot")
ages.has_key?("Spot")

# correct_answer =>
# ages.key?
# ages.include?
# ages.member?


# Quesiton 2
# Starting with this string:
munsters_description = "The Munsters are creepy in a good way."

# Convert the string in the following ways (code will be executed on original
# munsters_description above):
# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
# "The munsters are creepy in a good way."
# "the munsters are creepy in a good way."
# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."

# my_answer =>
puts munsters_description.swapcase!
puts munsters_description.capitalize!
puts munsters_description.downcase!
puts munsters_description.upcase!


# Question 3
# We have most of the Munster family in our age hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

# add ages for Marilyn and Spot to the existing hash
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

p ages.merge!(additional_ages)


# Question 4
# See if the name "Dino" appears in the string below:
advice = "Few things in life are as important as house training your pet dinosaur."

# my_answer =>
puts advice.include?("Dino")

# correct_answer =>
puts advice.match?("Dino")

# Question 5
# Show an easier way to write this array:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

# my_answer =>
flintstones = 
  ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
  
# correct_answer =>
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)


# Question 6
# How can we add the family pet "Dino" to our usual array:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# my_answer =>
flintstones << "Dino"


# Question 7
# In the previous practice problem we added Dino to our array like this:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"
# We could have used either Array#concat or Array#push to add Dino to the family How can we add multiple items to our array? (Dino and Hoppy)

# my_answer =>
flintstones.insert(2, "Dino", "Hoppy")

# example_of_answer =>
flintstones.push("Dino").push("Hoppy")
# or
flintstones.concat(%w(Dino Hoppy))


# Question 8
# Shorten the following sentence:
advice = "Few things in life are as important as house training your pet dinosaur."
# Review the String#slice! documentation, and use that method to make the return value "Few things in life are as important as ". But leave the advice variable as "house training your pet dinosaur.".
# As a bonus, what happens if you use the String#slice method instead?

# my_answer =>
p new_advice = advice.slice!(0..38)
p advice
# if slice was used instead the string would not be permentaly modified.

# example_of_answer =>
advice.slice!(0, advice.index('house'))
p advice


# Question 9
# Write a one-liner to count the number of lower-case 't' characters in the following string:
statement = "The Flintstones Rock!"

# my_answer =>
puts statement.count('t')


# Question 10
# Back in the stone age (before CSS) we used spaces to align things on the screen. If we had a table of Flintstone family members that was forty characters in width, how could we easily center that title above the table with spaces?
title = "Flintstone Family Members"

# my_answer =>
puts title.rjust(40)

# correct_nswer =>
puts title.center(40)


