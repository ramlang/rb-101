# Let's now take a look at an example with hashes. In this example we want to select the key-value pairs where the value is 'Fruit'. How would you implement a method like this?

=begin
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

# select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

def select_fruit(hash)
  hash.each do |key, value|
    hash.delete(key) unless value == 'Fruit'
  end
end

p select_fruit(produce)


# correct_answer =>
def select_fruit(produce_list)
  produce_keys = produce_list.keys
  counter = 0
  selected_fruits = {}

  loop do
    # this has to be at the top in case produce_list is empty hash
    break if counter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    if current_value == 'Fruit'
      selected_fruits[current_key] = current_value
    end

    counter += 1
  end

  selected_fruits
end


# Can you implement a double_numbers! method that mutates its argument?
my_numbers = [1, 4, 3, 7, 2, 6]

def double_numbers(numbers)
  p numbers.object_id
  counter = 0
  loop do
    break if counter == numbers.size
    numbers[counter] *= 2
    counter += 1
  end
  p numbers.object_id
  p numbers
end

double_numbers(my_numbers)
p my_numbers

# correct_answer =>
def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    numbers[counter] = current_number * 2

    counter += 1
  end

  numbers
end


# What if we wanted to transform the numbers based on their position in the array rather than their value?
def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end
=end


# Try coding a method that allows you to multiply every array item by a specified value...
def multiply(numbers, multiplied_by)
  multiplied_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= multiplied_by
    multiplied_numbers << current_number

    counter += 1
  end
  multiplied_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3)


# correct_answer =>
def multiply(numbers, multiplier)
  multiplied_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    multiplied_numbers << numbers[counter] * multiplier
    counter += 1
  end

  multiplied_numbers
end