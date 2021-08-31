# ----- loops 1 -----
=begin
loop do
  puts 'Just keep printing...'
  break
end

# -----

loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
    break
  end
  break
end

puts 'This is outside all loops.'

# -----

iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end

iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  break if iterations >= 5 # if order is swtiched this must change to >=
  iterations += 1
end

# -----

loop do
  puts 'Should I stop looping?'
  answer = gets.chomp
  break if answer == 'yes'
end

# -----

say_hello = true
count = 0

while say_hello
  puts 'Hello!'
  count += 1
  say_hello = false if count == 5
end

5.times do
  puts 'Hello!'
end

# -----

numbers = []

while numbers.length < 5
  numbers << rand(0..99)
end

puts numbers

# -----

 count = 1

until count > 10
  puts count
  count += 1
end

# -----

numbers = [7, 9, 13, 25, 18]

until numbers.empty?
  puts numbers.shift
end

numbers = [7, 9, 13, 25, 18]

count = 0

until count == numbers.size
  puts numbers[count]
  count += 1
end

# -----

for i in 1..100
  puts i if i.odd?
end

# -----

friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}"
end
=end
# ----- loops 2 -----

count = 1

loop do
  break if count > 5
  puts "#{count} is odd!" if count.odd?
  puts "#{count} is even!" if count.even?
  count += 1
end

# -----

loop do
  number = rand(100)
  puts number
  break if number <= 10
end

# -----

process_the_loop = [true, false].sample
if process_the_loop
  loop do 
    puts "The loop was processed"
    break
  end
else
  puts "The loop wasn't processed"
end

# -----

loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
  
  if answer != 4
    puts "Wrong answer! Try again."
  else
    puts "That's correct!"
    break
  end
  
end


loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i

  if answer == 4
    puts "That's correct!"
    break
  end

  puts 'Wrong answer. Try again!'
end

# -----

numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i
  numbers << input
  break if numbers.length == 5
end
puts numbers

# -----

names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do
  puts names.shift
  break if names.empty?
end

# -----

5.times do |index|
  puts index
  break if index == 2
end

# -----

number = 0

until number == 10
  number += 1
  next if number.odd?
  puts number
end

# -----

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)
  next unless number_a == 5 || number_b == 5
  puts "5 was reached!"
  break
end

loop do
  number_a += rand(2)
  number_b += rand(2)
  if number_a == 5 || number_b == 5
    puts "5 was reached!"
    break
  else
    next
  end
end

# -----

def greeting
  puts 'Hello!'
end

number_of_greetings = 2

while number_of_greetings > 0
  greeting
  number_of_greetings -= 1
end