# Question 1
# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# my_answer =>
# [1, 2, 2, 3]

# correct_answer =>
# 1
# 2
# 2
# 3


# Question 2
# Describe the difference between ! and ? in Ruby. And explain what would happen
# in the following scenarios:

# what is != and where should you use it?
  # my_answer =>
  # != is the NOT operator. It is used as a comparison operator to determine if
  # two expression are not equal to eachother. You should use it in a conditional
  # expression.

# put ! before something, like !user_name
  # my_answer =>
  # to put ! infront of a name changes will return false

# put ! after something, like words.uniq!
  # my_answer =>
  # to put ! after a method typically implies the change will be permanent however
  # this is not always the case and some methods do not have a ! at the end

# put ? before something
  # my_answer =>
  # putting ? in front of something can be setting up a ternary operator

# put ? after something
  # my_answer =>
  # putting ? after something signifies that you are returning a boolean

# put !! before something, like !!user_name
  # my_answer =>
  # putting !! in front of something will return true

# correct_answer =>
# != means "not equals"
# ? : is the ternary operator for if...else
# !!<some object> is used to turn any object into their boolean equivalent.
# !<some object> is used to turn any object into the opposite of their boolean
# equivalent, just like the above, but opposite.


# Question 3
# Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."

# my_answer =>
puts advice.gsub!("important", "urgent")


# Question 4
# The Ruby Array class has several methods for removing items from the array.
# Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]

# What do the following method calls do (assume we reset numbers to the original
# array between method calls)?

numbers.delete_at(1)
# my_answer =>
# this method will delete 2 from the array because it is providing an index

numbers.delete(1)
# my_answer =>
# this method will delete 1 from the array because it is providing a value


# Question 5
# Programmatically determine if 42 lies between 10 and 100.

# my_answer =>
puts (10..100).include?(42)

# example_of_answer =>
(10..100).cover?(42)


# Question 6
# Starting with the string show two different ways to put the expected "Four
# score and " in front of it.

famous_words = "seven years ago..."

# my_answer =>
famous_words.prepend('Four score and ')
famous_words.insert(0, 'Four score and ')

# example_of_answer =>
"Four score and " + famous_words
"Four score and " << famous_words


# Question 7
# If we build an array like this
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

# We will end up with this "nested" array:
["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

# Make this into an un-nested array.

# my_answer =>
flintstones.flatten!


# Question 8
# Given the hash below
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

# Turn this into an array containing only two elements: Barney's name and
# Barney's number

# my_answer =>
flintstones.select! { |k,v| k.include?('Barney') }

# example_of_answer =>
flintstones.assoc("Barney")