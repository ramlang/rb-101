require 'pry'
# Question 1
# Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).
# For this practice problem, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:
# The Flintstones Rock!
#  The Flintstones Rock!
#   The Flintstones Rock!
  
# my_answer =>  
10.times { |i| puts "The Flintstones Rock!".prepend(" " * i) }

# correct_answer =>
10.times { |number| puts (" " * number) + "The Flintstones Rock!" }


# Question 2
# The result of the following statement will be an error:
# puts "the value of 40 + 2 is " + (40 + 2)
# Why is this and what are two possible ways to fix this?

# my_answer =>
# The error is given because you cannot concatenate an integer to a string
puts "the value of 40 + 2 is #{40 + 2}"
puts "the value of 40 + 2 is " << (40 + 2).to_s

# example_of_answer =>
puts "the value of 40 + 2 is " + (40 + 2).to_s


# Question 3
# Alan wrote the following method, which was intended to show all of the factors of the input number:
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end

# Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.
# Bonus 1
# What is the purpose of the number % divisor == 0 ?
# Bonus 2
# What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)?

# my_answer =>

def factors(number)
  divisor = number
  factors = []
  loop do
    if divisor <= 0
      break
    elsif number % divisor == 0
      factors << number / divisor
    end
    divisor -= 1
  end
  factors
end

# my_answer =>
# The purpose of the modulus operator is to determine if the divisor is a facotr of the number.

# my_answer =>
# The purpose of the factors at the end of the method is to ensure that is the value that will be returned.

# correct_answer =>
=begin
while divisor > 0 do
  factors << number / divisor if number % divisor == 0
  divisor -= 1
end
=end

# Question 4
# Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer. Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# my_answer =>
# Yes,there is a difference between the two. The + operator cannot be used to add a new element to an array. Only push and << are capable of adding a new value to an array.

# correct_answer =>
# Yes, there is a difference. While both methods have the same return value, in the first implementation, the input argument called buffer will be modified and will end up being changed after rolling_buffer1 returns. That is, the caller will have the input array that they pass in be different once the call returns. In the other implementation, rolling_buffer2 will not alter the caller's input argument.


# Question 5
# Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator. A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.
# Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?
limit = 15

def fib(first_num, second_num)
  limit = 15 # my_answer => added; initialize the variable within the method
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

# correct_answer =>
# Ben defines limit before he calls fib. But limit is not visible in the scope of fib because fib is a method and does not have access to any local variables outside of its scope. You can make limit an additional argument to the definition of the fib method and pass it in when you call fib.


# Question 6
# What is the output of the following code?
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

# my_answer =>
# 34


# Question 7
# One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end
puts mess_with_demographics(munsters)

# Did the family's data get ransacked? Why or why not?

# my_answer =>
# No, because of the nested hash. in order to modify the values in the hash, I think the index would need to be specified first.

# correct_answer =>
# Remember that in Ruby, what gets passed to a method isn't the value of the object. Ruby passes the object_id of each argument to the method. The method stores these object_id's internally in locally scoped (private to the method) variables (named per the method definition's parameter list).
# Spot's demo_hash starts off pointing to the munsters hash. His program could wind up replacing that with some other object id and then the family's data would be safe.
# In this case, the program does not reassign demo_hash. So the actual hash object that is being messed with inside of the method IS the munsters hash.


# Question 8
# Method calls can take expressions as arguments. Suppose we define a method called rps as follows, which follows the classic rules of rock-paper-scissors game, but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")

# my_answer =>
# 1 paper
# 2 rock
# 3 rps(paper,rock)
# 4 paper
# 5 rps(paper, rock)
# 6 paper <= output


# Question 9
# Consider these two simple methods:
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

# What would be the return value of the following method invocation?
bar(foo)

# my_answer =>
# no
