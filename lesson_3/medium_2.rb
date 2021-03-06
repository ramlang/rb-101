# Question 1
# Predict how the values and object ids will change throughout the flow of the code below:
def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id # 42
  b_outer_id = b_outer.object_id # "forty two"
  c_outer_id = c_outer.object_id # [42]
  d_outer_id = d_outer.object_id # 42

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id # points to 42
    b_outer_inner_id = b_outer.object_id # points to "forty two"
    c_outer_inner_id = c_outer.object_id # points to [42]
    d_outer_inner_id = d_outer.object_id # points to 42

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts

    a_outer = 22 # reassigned from 42
    b_outer = "thirty three" # reassigned from "forty two"
    c_outer = [44] # reassigned from [42]
    d_outer = c_outer[0] # reassigned from 42

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts


    a_inner = a_outer # 22
    b_inner = b_outer # "thirty three"
    c_inner = c_outer # [44]
    d_inner = c_inner[0] # 44

    a_inner_id = a_inner.object_id # 22
    b_inner_id = b_inner.object_id # "thirty three"
    c_inner_id = c_inner.object_id # [44]
    d_inner_id = d_inner.object_id # 44

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block." # 42 
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block." # "forty two"
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block." # [42]
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block." # 42
  puts
  # rescue message
  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh" 
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end

# correct_answer =>
# Notice that Ruby re-used the "42 object with id 85" when the value was the same.
# Notice that Ruby did NOT change the id for any of the objects between outside and inside the block
# Notice that changing the values has forced Ruby to create new objects and refer to them with the original variable names.
# Notice that Ruby re-uses the objects under the hood when it can, but uses different ones for different values.
# (notice that each variable keeps its new object/object_id even when we leave the block.)
# Notice that once we leave the block, those variables that were defined inside the block lose their meaning.


# Question 2
# Let's look at object id's again from the perspective of a method call instead of a block. Here we haven't changed ANY of the code outside or inside of the block/method. We simply took the contents of the block from the previous practice problem and moved it to a method, to which we are passing all of our outer variables.
# Predict how the values and object ids will change throughout the flow of the code below:
def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id # 42
  b_outer_id = b_outer.object_id # "forty two"
  c_outer_id = c_outer.object_id # [42]
  d_outer_id = d_outer.object_id # 42

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)

  # 42, "forty two", [42], 42
  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call."
  puts
  # rescue puts ugh ohhhhh
  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts
end


def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)

  puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method." # 42
  puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method." # "forty two"
  puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method." # [42]
  puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method." # 42
  puts

  a_outer = 22 # reassigned from 42
  b_outer = "thirty three" # reassigned from "forty two"
  c_outer = [44] # reassigned from [42]
  d_outer = c_outer[0] # reassigned from 42

  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after." # 22
  puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after." # "thirty three"
  puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after." # [44]
  puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after." # 44
  puts

  a_inner = a_outer # assigned 22
  b_inner = b_outer # assigned "thirty three"
  c_inner = c_outer # assigned [44]
  d_inner = c_inner[0] # assigned 44

  a_inner_id = a_inner.object_id # same as outer object id
  b_inner_id = b_inner.object_id # same as outer object id
  c_inner_id = c_inner.object_id # same as outer object id
  d_inner_id = d_inner.object_id # same as outer object id

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer)."
  puts
end

# correct_answer =>
# Even though we changed the values of our "outer" variables inside the method call, we still have the same values and the same object id's down here AFTER the method call as we had before it!
# This is because our method call accepts VALUES as arguments. The names we give to those values in the definition of our method are SEPARATE from any other use of those same names.
# We used the same names there for convenience. We could just as easily have called the first parameter of our method definition a_Fred instead of a_outer.
# The method gets the VALUES of the arguments we pass, but the parameter variables inside the method have no other relationship to those outside of the method. The names were coincidental, and confusing in a useful way.


# Questions 3
# Let's call a method, and pass both a string and an array as arguments and see how even though they are treated in the same way by Ruby, the results can be different.
# Study the following code and state what will be displayed...and why:
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# my_answer =>
# my_string will have the value of "pumpkins" and my_array will have the value of ["pumpkins"]. This is because the values that are being passed to the method are passed by value. The method does not mutate the caller?

# correct_answer =>
# My string looks like this now: pumpkins
# My array looks like this now: ["pumpkins", "rutabaga"]

# In both cases, Ruby passes the arguments "by value", but unlike some other languages, the value that gets passed is a reference to some object. The string argument is passed to the method as a reference to an object of type String. Similarly, the array is passed to the method as a reference to an object of type Array.
# The important distinction is that while a reference is passed, the method initializes a new local variable for both the string and the array and assigns each reference to the new local variables. These are variables that only live within the scope of the method definition.
# The difference lies in what Ruby does when the program executes either a String#+= operation or an Array#<< operation.
# The String#+= operation is re-assignment and creates a new String object. The reference to this new object is assigned to a_string_param. The local variable a_string_param now points to "pumpkinsrutabaga", not "pumpkins". It has been re-assigned by the String#+= operation. This means that a_string_param and my_string no longer point to the same object.
# With the array, one array object can have any number of elements. When we attach an additional element to an array using the << operator, Ruby simply keeps using the same object that was passed in, and appends the new element to it.
# So, because the local variable an_array_param still points to the original object, the local variables my_array and an_array_param are still pointing at the same object, and we see the results of what happened to the array "outside" of the method.


# Question 4
# Let's turn the tables and have the string show a modified output, while the array thwarts the method's efforts to modify the caller's version of it.
def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# my_answer =>
# My string looks like this now: pumkinsrubtabaga
# My array looks like this now: ["pumpkins"]


# Question 5
# Depending on a method to modify its arguments can be tricky:
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# Whether the above "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.
# How can we change this code to make the result easier to predict and easier for the next programmer to maintain?

# my_answer =>
def tricky_method(param)
  param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string)
tricky_method(my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# correct_answer =>
def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"


# Question 6
# How could the following method be simplified without changing its return value?
def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end

# my_answer =>
def color_valid(color)
  color == "blue" || color == "green" ? true : false
end

puts color_valid("blue")

# correct_answer =>
def color_valid(color)
  color == "blue" || color == "green"
end

