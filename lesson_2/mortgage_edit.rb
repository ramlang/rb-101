require 'yaml'
MESSAGES = YAML.load_file('mortgage_text.yml')

# when methods have parameters be sure to include parentheses
def prompt(message)
  puts "\n~*~ #{message} ~*~\n"
end

def question(message)
  print "#{message} => "
end

def valid_amount?(loan_amount)
  loan_amount.to_f.to_s == loan_amount || loan_amount.to_i.to_s == loan_amount
end

def valid_rate?(rate)
  rate.to_f.to_s == rate || rate.to_i.to_s == rate
end

def valid_time?(time)
  time.to_f.to_s == time || time.to_i.to_s == time
end

prompt MESSAGES['greeting']
puts ''

loop do
  type = ''
  loop do
    question MESSAGES['mortgage_type']
    type = gets.chomp
    if type.downcase.include? 'car'
      type = 'car payment'
      break
    elsif type.downcase.include? 'home'
      type = 'home mortgage'
      break
    else
      prompt MESSAGES['invalid']
    end
  end

  loan_amount = ''
  loop do
    question MESSAGES['loan_amount']
    loan_amount = gets.chomp
    if valid_amount? loan_amount
      break
    else
      prompt MESSAGES['invalid']
    end
  end

  interest_rate = ''
  loop do
    question MESSAGES['rate']
    interest_rate = gets.chomp
    if valid_rate? interest_rate
      break
    else
      prompt MESSAGES['invalid']
    end
  end

  loan_duration = ''
  loop do
    question MESSAGES['time']
    loan_duration = gets.chomp
    if valid_time? loan_duration
      break
    else
      prompt MESSAGES['invalid']
    end
  end

  prompt MESSAGES['wait']

  monthly_interest_rate = interest_rate.to_f / 100 / 12
  months = loan_duration.to_f * 12
  loan_amount = loan_amount.to_f
  monthly_payment = loan_amount *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**(-months)))

  if monthly_payment.nan? || monthly_payment == 0
    prompt MESSAGES['zero']
  else
    prompt "Your #{type} will be $#{monthly_payment.round(2)} per "\
    "month with a #{interest_rate.to_f}% APR over #{months.truncate} month(s)."
  end
  puts ''

  question MESSAGES['repeat']
  answer = gets.chomp
  break unless answer.downcase.include? 'y'
end

prompt MESSAGES['goodbye']
puts ''
