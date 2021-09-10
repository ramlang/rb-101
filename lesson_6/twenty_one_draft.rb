SUITS = ['H', 'D', 'C', 'S']
VALUES = ('2'..'9').to_a + ['J', 'Q', 'K', 'A']
NEW_LINE = "\n"
GAME_NAME = "Twenty One"
WINNING_NUMBER = 21
DEALER_STAYS = 17
POINTS_TO_WIN = 2

def header(msg)
  puts "   ~ #{msg} ~"
  puts "---------------------"
end

def continue?
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
  puts "            ~ Let's play #{GAME_NAME}! ~"
  puts NEW_LINE
  puts "Get the sum of your cards close to or equal to #{WINNING_NUMBER}."
  puts "If you go over #{WINNING_NUMBER} or the dealer is closer, you lose!"
  puts NEW_LINE
  continue?
  system 'clear'
end
# rubocop:enable Metrics/MethodLength

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def deal_cards!(deck, num)
  dealt_cards = deck.sample(num)
  deck.delete_if { |card| dealt_cards.include?(card) }
  dealt_cards
end

def display_cards(hand)
  hand.each_with_index do |card, ind|
    print "Card #{ind + 1}: "
    case card[0]
    when 'H'
      print "#{card[1]} of Hearts\n"
    when 'D'
      print "#{card[1]} of Diamonds\n"
    when 'S'
      print "#{card[1]} of Spades\n"
    when 'C'
      print "#{card[1]} of Clubs\n"
    end
  end
end

def display_scoreboard(current_score)
  header "Points"
  puts "Player = #{current_score[:player]}"
  puts "Dealer = #{current_score[:dealer]}"
  puts NEW_LINE
end

def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > WINNING_NUMBER
  end

  sum
end

def display_total(num)
  puts "TOTAL = #{num}"
  puts "---------------------"
end

def display_current_hands(hands, totals)
  header "Dealer Hand"
  hide_dealer_cards(hands[:dealer])
  display_total('?')

  puts NEW_LINE

  header "Player Hand"
  display_cards(hands[:player])
  display_total(totals[:player])
end

def display_table(scrbrd, hands, totals)
  # system 'clear'
  display_scoreboard(scrbrd)
  display_current_hands(hands, totals)
end
  
def busted?(total)
  total > WINNING_NUMBER
end

def end_current_game(scrbrd, hands, totals)
  show_hands(hands, totals)
  puts NEW_LINE
  update_scoreboard(scrbrd, totals)
  display_winner(totals) unless win_by_points(scrbrd)
end

def player_turn(deck, scrbrd, hands, totals)
  answer = nil
  loop do
    puts NEW_LINE
    print "Hit or stay? => "
    answer = gets.chomp
    hands[:player] += deal_cards!(deck, 1) if answer == 'hit'
    totals[:player] = total(hands[:player])
    display_table(scrbrd, hands, totals)
    break if answer == 'stay' || busted?(totals[:player])
  end
end

def dealer_turn(deck, scrbrd, hands, totals)
  while totals[:dealer] < DEALER_STAYS
    hands[:dealer] += deal_cards!(deck, 1)
    totals[:dealer] = total(hands[:dealer])
    display_table(scrbrd, hands, totals)
    sleep(1.5)
  end
end

def hide_dealer_cards(hand)
  hand.each_index do |ind|
    if ind == 0
      show_one_dealer_card = [hand[0]]
      display_cards(show_one_dealer_card)
    else
      print "Card #{ind + 1}: ?\n"
    end
  end
end

def decide_to_stay(name)
  puts NEW_LINE
  puts "#{name} chooses to stay!"
  puts NEW_LINE
  continue?
end

def determine_winner(totals)
  if totals[:dealer] > WINNING_NUMBER
    :dealer_busted
  elsif totals[:player] > WINNING_NUMBER
    :player_busted
  elsif totals[:dealer] > totals[:player]
    :dealer
  elsif totals[:dealer] < totals[:player]
    :player
  else
    :tie
  end
end

def display_winner(totals)
  result = determine_winner(totals)
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

def update_scoreboard(scrdbrd, totals)
  winner = determine_winner(totals)
  case winner
  when :player_busted
    scrdbrd[:dealer] += 1
  when :dealer_busted
    scrdbrd[:player] += 1
  when :dealer
    scrdbrd[:dealer] += 1
  when :player
    scrdbrd[:player] += 1
  when :tie
    scrdbrd
  end
end

def win_by_points(scrdbrd) # refactor to single fill in blank using hash keys and values
  if scrdbrd[:player] == POINTS_TO_WIN
    continue?
    puts "Player won #{POINTS_TO_WIN} rounds! Player wins!"
    puts "---------------------"
    display_scoreboard(scrdbrd)
    return true
  elsif scrdbrd[:dealer] == POINTS_TO_WIN
    continue?
    puts "Dealer won #{POINTS_TO_WIN} rounds! Dealer wins!"
    puts "---------------------"
    display_scoreboard(scrdbrd)
    return true
  end
end

def show_hands(hands, totals)
  system 'clear'
  header "Dealer Hand"
  display_cards(hands[:dealer])
  display_total(totals[:dealer])

  puts NEW_LINE

  header "Player Hand"
  display_cards(hands[:player])
  display_total(totals[:player])
end

def play_again?
  loop do
    print "Play again? (y/n) => "
    answer = gets.chomp
    return true if answer == 'y'
    return false if answer == 'n'
  end
end

system 'clear'
game_intro
scoreboard = { player: 0, dealer: 0 }

loop do
  current_deck = initialize_deck
  
  hands = {
    player: deal_cards!(current_deck, 2),
    dealer: deal_cards!(current_deck, 2)
  }

  totals = {
    player: total(hands[:player]),
    dealer: total(hands[:dealer])
  }

  display_table(scoreboard, hands, totals)

  loop do
    player_turn(current_deck, scoreboard, hands, totals)
    totals[:player] = total(hands[:player]) # ****************
    
    if busted?(totals[:player])
      end_current_game(scoreboard, hands, totals)
      break
    else
      decide_to_stay('Player')
    end

    dealer_turn(current_deck, scoreboard, hands, totals)
    totals[:dealer] = total(hands[:dealer])
    
    if busted?(totals[:dealer])
      end_current_game(scoreboard, hands, totals)
      break
    else
      decide_to_stay('Dealer')
    end

    end_current_game(scoreboard, hands, totals)
    break
  end
  puts NEW_LINE
  break unless play_again?
  system 'clear'
  scoreboard = { player: 0, dealer: 0 } if win_by_points(scoreboard)
end

puts NEW_LINE
puts "Thanks for playing #{GAME_NAME}! Good bye!"
