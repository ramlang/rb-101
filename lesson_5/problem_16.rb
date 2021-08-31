# A UUID is a type of identifier often used as a way to uniquely identify items...which may not all be created by the same system. That is, without any form of synchronization, two or more separate computer systems can create new items and label them with a UUID with no significant chance of stepping on each other's toes.

# It accomplishes this feat through massive randomization. The number of possible UUID values is approximately 3.4 X 10E38.

# Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.

# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Write a method that returns one UUID when called with no parameters.

# my_answer =>

# PEDAC

# Problem ---
# input is nothing
# output is a string
# problem domain = randomly generate characters, create strings of varying lengths, join different strings together with dashes, only use lower case and characters 1 - 9, generate without any input
# explicit reqs = 8-4-4-4-12 number format, return is a string, lowercase and numbers, not input
# implicit reqs = no uppercase, no zero?

# mental model = create a hash with values of arrays, randomly generate elements within the arrays up to a certain number, store array, once all keys have values, join the values together, return the string

# Examples/ Test Cases ---
# => "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Data Structure ---
# input = none
# inbetween = hash
# output = string
# methods = Array#join, iterator or loop, Random#rand, Array#sample

# Algorithm ---
# create a place to store each randomly generated section of string like a hash or variable/Array
# randomly generate the sections of string
# combine the sections togehter

# Code with Intent ---

CHARS = ('a'..'f').to_a + ('1'..'9').to_a

def fill_array(hash)
  hash.map do |key, value|
    count = key
    loop do
      break if count == 0
      value << CHARS.sample
      count -= 1
    end
  hash
  end
end

def uuid()
  sections = [{8 => []}, {4 => []}, {4 => []}, {4 => []}, {12 => []}]
  result = []
  sections.map do |sub_hash|
    fill_array(sub_hash)
    result << sub_hash.values.join
  end
  result.join('-')
end

p uuid()


# correct_answer =>
def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end

