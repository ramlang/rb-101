# Using the each method, write some code to output all of the vowels from the strings.
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# my_answer =>
hsh.each do |key, value|
value.each do |word|
    word.chars.each do |letter|
      print letter if 'aeiou'.include?(letter)
    end
  end
end


# example_of_answer =>
vowels = 'aeiou'

hsh.each do |_, value|
  value.each do |str|
    str.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end

# using _ instead of the variable keys indicates that the variable will not be used in the block
  