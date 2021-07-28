VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  o: 'spock',
  l: 'lizard'
}
GAME_SCORE = { player: 0, computer: 0 }
WINNING_SCORE = 3
NEW_LINE = "\n"

def reset_screen
  system('clear')
end

def fancy_prompt(message)
  puts NEW_LINE + "~*~ #{message} ~*~"
end

def input_prompt(message)
  print "#{message} => "
end

def print_stars
  puts NEW_LINE
  36.times { print '* ' }
  puts NEW_LINE
end

def display_options
  puts NEW_LINE
  puts "Enter one of the following characters..."
  VALID_CHOICES.each do |key, value|
    puts "(#{key}) #{value.capitalize}"
  end
  puts NEW_LINE
end

def display_moves(player, computer)
  print_stars
  puts "\nPlayer uses #{player.upcase}"
  sleep(1.0)
  puts "Computer uses #{computer.upcase}"
  print_stars
  sleep(2.3)
  reset_screen
end

def print_result(player, computer, hash)
  if hash[player.to_sym].include?(computer)
    'Player wins!'
  elsif hash[computer.to_sym].include?(player)
    'Computer wins!'
  else
    "It's a tie!"
  end
end

def update_score(result)
  if result.include?('Player')
    GAME_SCORE[:player] += 1
  elsif result.include?('Computer')
    GAME_SCORE[:computer] += 1
  else
    GAME_SCORE
  end
end

def print_scoreboard(player, computer)
  print_stars
  puts "\nPlayer score = #{player}"
  puts "Computer's score = #{computer}"
  print_stars
end

def print_winner(player_score)
  if player_score == WINNING_SCORE
    fancy_prompt("Congrats you won #{WINNING_SCORE} games!")
  else
    fancy_prompt("Oh no! You lost #{WINNING_SCORE} games!")
  end
end

player_moves = {
  rock: ['lizard', 'scissors'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['spock', 'paper'],
  spock: ['scissors', 'rock']
}

print_stars
fancy_prompt('Welcome to my Ruby Rock, Paper, Scissors, Spock & Lizard Game!')

loop do
  choice = ''
  until GAME_SCORE.value?(WINNING_SCORE)

    loop do
      input_prompt(display_options)
      choice = gets.chomp
      if VALID_CHOICES.include?(choice.downcase.to_sym)
        break
      else
        fancy_prompt('Oops! Please try again.')
      end
    end

    player_choice = VALID_CHOICES[choice.downcase.to_sym]
    computer_choice = VALID_CHOICES.values.sample

    reset_screen
    display_moves(player_choice, computer_choice)
    result = print_result(player_choice, computer_choice, player_moves)
    fancy_prompt(result)
    puts NEW_LINE
    sleep(2.3)
    reset_screen

    update_score(result)
    print_scoreboard(GAME_SCORE[:player], GAME_SCORE[:computer])
  end

  print_winner(GAME_SCORE[:player])
  puts NEW_LINE
  sleep(5.0)
  reset_screen

  answer = ''
  while answer.downcase != 'no' && answer.downcase != 'yes'
    input_prompt('Would you like to play again?')
    answer = gets.chomp
    puts NEW_LINE
  end

  break unless answer.downcase == 'yes'

  GAME_SCORE[:player] = 0
  GAME_SCORE[:computer] = 0
end

fancy_prompt('Thanks for playing! See you next time.')
puts NEW_LINE
