# tic tac toe steps
# ----------
# 1. Display the initial empty 3 x 3 board
# 2. Ask user to mark a square
# 3. Computer marks square
# 4. Display the updated board state
# 5. If winner, display winner
# 6. If board is full, display tie
# 7 If neither winner or full, go to step 2
# 8. Play again?
# 9. If yes, go to step 1
# 10. Good bye
# ----------
require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
WINNING_SCORE = 1

def prompt(msg)
  puts "=> #{msg} "
end

def display_scoreboard(scrbrd)
  puts "SCOREBOARD"
  puts "-------------"
  puts "PLAYER (X) = #{scrbrd[:player]}"
  puts "COMPUTER (O) = #{scrbrd[:computer]}"
end

# rubocop disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, scrbrd)
  system 'clear'
  prompt "Win #{WINNING_SCORE} games against the Computer!\n"
  display_scoreboard(scrbrd)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter= ', ', word= 'or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def who_goes_first?()
  loop do
    prompt "Choose who will go first: Player or Computer" +
    " or random: "
    answer = gets.chomp.downcase
    return 'player' if answer == 'player'
    return 'computer' if answer == 'computer'
    return [true, false].sample if answer == 'random'
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place your piece" +
           " #{joinor(empty_squares(brd))}: "
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Invalid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end


def computer_strategy!(brd, marker)
  lines = WINNING_LINES.select do |line|
    brd.values_at(*line).count(marker) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
  end
  return false if lines.empty?
  lines.sample.each do |num|
    brd[num] = COMPUTER_MARKER if empty_squares(brd).include?(num)
  end
end

def computer_turn!(brd)
  if computer_strategy!(brd, COMPUTER_MARKER) ||
    computer_strategy!(brd, PLAYER_MARKER)
    return
  elsif brd[5] == INITIAL_MARKER
    brd[5] = COMPUTER_MARKER
    return
  elsif computer_places_piece!(brd)
  end
end

def place_piece!(brd, player)
  if player == 'player'
    player_places_piece!(brd)
  else
    computer_turn!(brd)
  end
end

def switch_players(player)
  return player = 'computer' if player == 'player'
  return player = 'player' if player == 'computer'
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def play_again?
  system 'clear'
  loop do
    prompt 'Play again? (y/n)'
    answer = gets.chomp.downcase
    return true if answer == 'y'
    return false if answer == 'n'
  end
end

def update_scoreboard(winner, scrbrd)
  scrbrd[winner.downcase.to_sym] += 1 unless winner == nil
end

def grand_winner?(scrbrd)
  if scrbrd.values.include?(WINNING_SCORE)
    scrbrd.key(WINNING_SCORE)
  end
end

def print_grand_winner(winner, scrbrd)
  winner = winner.capitalize
  if winner == 'Player'
    prompt "Well done! #{winner} won" +
           " #{WINNING_SCORE} games in a row!"
  elsif winner == 'Computer'
    prompt "Oh no! #{winner} won" +
           " #{WINNING_SCORE} games in a row!"
  end
end

loop do
  prompt "Let's play Tic Tac Toe!\n"
  current_player = who_goes_first?
  scoreboard = {player: 0, computer: 0}
  board = initialize_board
  loop do
    board = initialize_board
    loop do
      display_board(board, scoreboard)
      place_piece!(board, current_player)
      current_player = switch_players(current_player)
      break if someone_won?(board) || board_full?(board)
    end
  
    display_board(board, scoreboard)
    current_winner = detect_winner(board)
    
    if someone_won?(board)
      prompt "#{current_winner} won!"
    else
      prompt "It's a tie!"
    end

    update_scoreboard(current_winner, scoreboard)
    STDIN.gets
    
    break if !!grand_winner?(scoreboard)
    break unless play_again?
  end
  if scoreboard.values.include?(WINNING_SCORE)
    winner = grand_winner?(scoreboard).to_s
    print_grand_winner(winner, scoreboard)
    STDIN.gets
    break unless play_again?
  else
    break
  end
end

prompt 'Thanks for playing Tic Tac Toe! Good bye!'
