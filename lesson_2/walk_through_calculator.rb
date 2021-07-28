# ask the use for two numbers
# ask for the type of operation to perform: add, subtract, multiply, divide
# perform the operatrion
# output the result
require 'yaml'
MESSAGES = YAML.load_file('walk_through_calculator.yml')
LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  print("#{message} => ")
end

def prompt_no_arrow(key)
  message = messages(key, LANGUAGE)
  puts("#{message}")
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def valid_number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt('welcome')

name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt('valid_name')
  else
    break
  end
end
puts("Hello #{name}!")
loop do
  number1 = ''
  loop do
    prompt('first_number')
    number1 = gets.chomp
    if valid_number?(number1)
      break
    else
      prompt('valid_number')
    end
  end
  number2 = ''
  loop do
    prompt('second_number')
    number2 = gets.chomp
    if valid_number?(number2)
      break
    else
      prompt('valid_number')
    end
  end
  operator_prompt = <<-MSG
  What operation would you like to perform?
  1) add
  2) subtract
  3) multiply
  4) divide
  
  MSG
  print("#{operator_prompt} =>")
  operator = ''
  loop do
    operator = gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('valid_operator')
    end
  end
  puts("#{operation_to_message(operator)} two numbers...")
  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end
  puts("The result is : #{result}")
  prompt('repeat')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt_no_arrow('goodbye')
response = Kernel().gets.chomp
puts response
