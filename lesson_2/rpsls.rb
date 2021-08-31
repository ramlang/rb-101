VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  o: 'spock',
  l: 'lizard'
}

PLAYER_MOVES = {
  rock: ['lizard', 'scissors'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['spock', 'paper'],
  spock: ['scissors', 'rock']
}

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

def enter_to_continue
  puts NEW_LINE
  fancy_prompt('Press enter to continue')
  STDIN.gets
end

def display_options
  puts NEW_LINE
  puts "Enter one of the following characters..."
  VALID_CHOICES.each do |key, value|
    puts "(#{key}) #{value.capitalize}"
  end
  puts NEW_LINE
end

def get_user_choice()
  choice = ''
  loop do
    input_prompt(display_options)
    choice = gets.chomp
    if VALID_CHOICES.include?(choice.downcase.to_sym)
       break
    else
      fancy_prompt('Oops! Please try again.')
    end
  end
  choice
end

def display_moves(player, computer)
  print_stars
  puts "\nPlayer uses #{player.upcase}"
  sleep(1.0)
  puts "Computer uses #{computer.upcase}"
  print_stars
  sleep(1.0)
  enter_to_continue
  reset_screen
end

def determine_result(player, computer, hash)
  if hash[player.to_sym].include?(computer)
    winner = 'Player'
  elsif hash[computer.to_sym].include?(player)
    winner = 'Computer'
  else
    winner = 'Tie'
  end
  winner
end

def print_result(winner)
  if winner.include?('Player')
    'Player wins!'
  elsif winner.include?('Computer')
    'Computer wins!'
  else
    "It's a tie!"
  end
end

def update_score(result, score)
  if result.include?('Player')
    score[:player] += 1
  elsif result.include?('Computer')
    score[:computer] += 1
  else
    score
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

def play_again?()   
  answer = ''
  while answer.downcase != 'no' && answer.downcase != 'yes'
    input_prompt('Would you like to play again? (yes/no)')
    answer = gets.chomp
    puts NEW_LINE
  end
  if answer.downcase == 'yes'
    true
  else
    false
  end
end

reset_screen
print_stars
fancy_prompt('Welcome to my Ruby Rock, Paper, Scissors, Spock & Lizard Game!')
fancy_prompt('You must win 3 rounds to win the game')

loop do
  game_score = { player: 0, computer: 0 }
  until game_score.value?(WINNING_SCORE)
    choice = get_user_choice()
    player_choice = VALID_CHOICES[choice.downcase.to_sym]
    computer_choice = VALID_CHOICES.values.sample

    reset_screen
    display_moves(player_choice, computer_choice)
    round_result = determine_result(player_choice, computer_choice, PLAYER_MOVES)
    
    fancy_prompt(print_result(round_result))
    puts NEW_LINE
    sleep(1.0)
    enter_to_continue
    reset_screen

    update_score(round_result, game_score)
    print_scoreboard(game_score[:player], game_score[:computer])
    sleep(1.0)
    enter_to_continue
    reset_screen
  end

  print_winner(game_score[:player])
  puts NEW_LINE
  sleep(1.0)
  enter_to_continue
  reset_screen

  break unless play_again?()

  game_score[:player] = 0
  game_score[:computer] = 0
end

fancy_prompt('Thanks for playing! See you next time.')
puts NEW_LINE
