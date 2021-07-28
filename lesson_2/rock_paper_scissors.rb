VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  o: 'spock',
  l: 'lizard'
}

def reset_screen
  system('clear')
end

def prompt(message)
  puts "\n~*~ #{message} ~*~"
  puts ''
end

def arrow_prompt(message)
  print message + " => "
end

def print_stars
  puts ''
  36.times do
    print '* '
  end
  puts "\n"
end

def round_result(player, computer, hash)
  if hash[player.to_sym][computer.to_sym]
    'Player wins!'
  elsif hash[computer.to_sym][player.to_sym]
    'Computer wins!'
  else
    "It's a tie!"
  end
end

def print_score(player, computer)
  puts "Player score = #{player}"
  puts "Computer's score = #{computer}"
  print_stars()
end

player_moves = {
  rock: { lizard: true, scissors: true },
  paper: { rock: true, spock: true },
  scissors: { paper: true, lizard: true },
  lizard: { spock: true, paper: true },
  spock: { scissors: true, rock: true }
}

print_stars()
prompt('Welcome to my Ruby Rock, Paper, Scissors, Spock & Lizard Game!')
loop do
  choice = ''
  player_score = 0
  computer_score = 0
  until player_score == 3 || computer_score == 3
    loop do
      letter_choices = <<-MSG

      Enter one of the following characters...
      
      (r) Rock
      (p) Paper
      (s) Scissors
      (o) Spock
      (l) Lizard

      MSG
      arrow_prompt(letter_choices)
      choice = gets.chomp
      if VALID_CHOICES.include?(choice.to_sym)
        break
      else
        prompt('Oops! Please try again.')
      end
    end
    player_choice = VALID_CHOICES[choice.to_sym]
    
    valid_choice_array = VALID_CHOICES.values
    computer_choice = valid_choice_array.sample
    reset_screen
    puts "Player uses #{player_choice.upcase}"
    sleep(1.0)
    puts "Computer uses #{computer_choice.upcase}"
    sleep(2.5)
    reset_screen
    result = round_result(player_choice, computer_choice, player_moves)
    prompt(result)
    puts ''
    sleep(2.0)
    reset_screen
    if result.include?('Player')
      player_score += 1
    elsif result.include?('Computer')
      computer_score += 1
    else
      player_score += 0
      computer_score += 0
    end
    print_stars
    print_score(player_score, computer_score)
  end

  if player_score == 3
    prompt("Congrats you won 3 games!")
  else
    prompt("Oh no! You lost 3 games!")
  end
  print_stars()
  puts ''
  sleep(5.0)
  reset_screen
  arrow_prompt('Would you like to play again?')
  answer = gets.chomp
  puts ''
  
  break unless answer.downcase.start_with?('y')
end
prompt('Thanks for playing! See you next time.')
print_stars()
