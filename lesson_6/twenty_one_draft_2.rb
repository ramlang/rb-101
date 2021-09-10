require 'pry'

GAME_TITLE = 'Twenty One'
NEW_LINE = "\n"
DASHED_LINE = "---------------------"
SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
VALUES = ('2'..'9').to_a + ['Jack', 'Queen', 'King', 'Ace']
WINNING_SUM = 21
STAY = 17
WINNING_POINTS = 3

def header(title)  # prints title
  puts "~ #{title} ~"
  puts DASHED_LINE
end

def continue? # prompts to hit enter
  puts "Press ENTER to continue..."
  STDIN.gets
end

# rubocop:disable Metrics/MethodLength
def game_intro
  puts "     _______    _______    _______    _______"
  puts "    |2      |  |3      |  |5      |  |A      |"
  puts "    |       |  |  / \\  |  |       |  |   _   |"
  puts "    | / V \\ |  | /   \\ |  |  / \\  |  |  ( )  |"
  puts "    | \\   / |  | \\   / |  | (_ _) |  | (_ _) |"
  puts "    |   v   |  |  \\ /  |  |   |   |  |   |   |"
  puts "    |      2|  |      3|  |      5|  |      A|"
  puts "    |_______|  |_______|  |_______|  |_______|"
  puts NEW_LINE
  puts "            ~ Let's play #{GAME_TITLE}! ~"
  puts NEW_LINE
  puts "Get the sum of your cards close to or equal to #{WINNING_SUM}."
  puts "If you go over #{WINNING_SUM} or the dealer is closer, you lose!"
  puts NEW_LINE
  continue?
  system 'clear'
end
# rubocop:enable Metrics/MethodLength

def initialize_deck # creates and shuffles deck
  SUITS.product(VALUES).shuffle
end

def deal_two_cards!(deck, player_cards, dealer_cards) # deals cards to player, deals cards to dealer
  2.times do                                          # removes cards from deck
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
end

def deal_next_card!(deck, cards) # deals card, removes from deck
  cards << deck.pop
end

def print_card_names(hand) # prints cards
  hand.each_with_index do |card, ind|
    puts "Card #{ind + 1}: #{card[1]} of #{card[0]}"
  end
end

def correct_for_ace!(hand_values, sum) # correct for aces adjusting the sum
  hand_values.select { |value| value == "Ace" }.count.times do
    sum -= 10 if sum > WINNING_SUM
  end
  sum
end

def calculate_total(hand) # calculates total and calls correct_for_ace! method
  sum = 0
  values = hand.map { |card| card[1] }
  
  values.each do |value|
    if value == "Ace"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end
  sum = correct_for_ace!(values, sum)
end

def display_total(name, num= '?') # displays total
  header "#{name} Total = #{num}"
end

def display_points(pts_hash) # formats the game points
  puts NEW_LINE
  print "     "
  header "Points"
  pts_hash.each do |key, value|
    puts "#{key.to_s.capitalize} = #{value}"
  end
  puts DASHED_LINE
end

def display_dealer_cards(dlr_cards, dlr_total, show)
  if show
    display_total('Dealer', dlr_total)
    print_card_names(dlr_cards)
  else
    display_total('Dealer') 
    hide_cards(dlr_cards)
  end
end

def display_table(pts, ply_cards, dlr_cards, ply_total, dlr_total, show)
  puts NEW_LINE
  display_dealer_cards(dlr_cards, dlr_total, show)
  puts NEW_LINE
  
  display_total('Player', ply_total)
  print_card_names(ply_cards)
  display_points(pts)
  puts NEW_LINE
end

def hide_cards(hand)  # calls print_card_names and prints hidden cards
  hand.each_index do |ind|
    if ind == 0
      visible_card = [hand[0]]
      print_card_names(visible_card)
    else
      print "Card #{ind + 1}: ?\n"
    end
  end
end

def player_turn(deck, pts, ply_cards, dlr_cards, ply_total, dlr_total)
  loop do
    answer = hit_or_stay?
    if answer == 'hit'
      deal_next_card!(deck, ply_cards)
      ply_total = calculate_total(ply_cards)
      display_table(pts, ply_cards, dlr_cards, ply_total, dlr_total, false)
      break if busted?(ply_total)
    else
      display_table(pts, ply_cards, dlr_cards, ply_total, dlr_total, false)
      break
    end
  end
end

def hit_or_stay?
  answer = nil
    loop do
      print "Hit or stay? => "
      answer = gets.chomp
      break if answer == 'hit' || answer == 'stay'
    end
  system 'clear'
  answer
end
  
def dealer_turn(deck, pts, ply_cards, dlr_cards, ply_total, dlr_total)
    while dlr_total < STAY
      deal_next_card!(deck, dlr_cards)
      dlr_total = calculate_total(dlr_cards)
      system 'clear'
      display_table(pts, ply_cards, dlr_cards, ply_total, dlr_total, false)
      sleep(1.7)
    end
end

def busted?(total) # evaluates total
  total > WINNING_SUM
end

def stay_and_continue(name) # prints stay message, calls continue? method
  puts "#{name} chooses to stay!"
  puts NEW_LINE
  continue?
end

def determine_round_winner(ply_total, dlr_total) # if/else statement, returns key
  if dlr_total > WINNING_SUM
    :dealer_busted
  elsif ply_total > WINNING_SUM
    :player_busted
  elsif dlr_total > ply_total
    :dealer
  elsif dlr_total < ply_total
    :player
  else
    :tie
  end
end

def display_winner(result) # case statement, prints message
  case result
  when :player_busted
    puts "Oh no! You busted. Dealer wins!"
  when :dealer_busted
    puts "Dealer busted. Player wins!"
  when :dealer
    puts "Dealer wins!"
  when :player
    puts "Player wins!"
  when :tie
    puts "It's a tie!"
  end
end

def display_game_winner(pts_hash) # prints message
  if pts_hash[:player] == WINNING_POINTS
    puts "Player won #{WINNING_POINTS} rounds!"
    puts DASHED_LINE
  elsif pts_hash[:dealer] == WINNING_POINTS
    puts "Dealer won #{WINNING_POINTS} rounds!"
    puts DASHED_LINE
  end
end

def update_points(winner, pts_hash) # adds points to score
  case winner
  when :player_busted
    pts_hash[:dealer] += 1
  when :dealer_busted
    pts_hash[:player] += 1
  when :dealer
    pts_hash[:dealer] += 1
  when :player
    pts_hash[:player] += 1
  when :tie
    pts_hash
  end
end

def play_again? # asks user for input
  loop do
    print "Play again? (y/n) => "
    answer = gets.chomp
    return true if answer == 'y'
    return false if answer == 'n'
  end
end


system 'clear'

score = { player: 0, dealer: 0 }
game_intro

loop do
  system 'clear'
  deck = initialize_deck

  player = []
  dealer = []
  
  deal_two_cards!(deck, player, dealer)
  
  player_total = calculate_total(player)
  dealer_total = calculate_total(dealer)

  display_table(score, player, dealer, player_total, dealer_total, false)
  loop do
    player_turn(deck, score, player, dealer, player_total, dealer_total)
    player_total = calculate_total(player)
    busted?(player_total) ? break : stay_and_continue('Player')

    display_table(score, player, dealer, player_total, dealer_total, false)
    dealer_turn(deck, score, player, dealer, player_total, dealer_total)
    dealer_total = calculate_total(dealer)
    busted?(dealer_total) ? break : stay_and_continue('Dealer')
    
    break
  end
  system 'clear'
  display_table(score, player, dealer, player_total, dealer_total, true)
  result = determine_round_winner(player_total, dealer_total)
  update_points(result, score)
  display_winner(result) unless display_game_winner(score)
  continue?
  
  break unless play_again?
end

puts NEW_LINE
puts "Thanks for playing #{GAME_TITLE}! Good bye!"