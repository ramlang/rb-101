GAME_TITLE = 'Twenty One'
NEW_LINE = "\n"
DASHED_LINE = "---------------------"
SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
VALUES = ('2'..'9').to_a + ['Jack', 'Queen', 'King', 'Ace']
WINNING_SUM = 21
STAY = 17
WINNING_POINTS = 3

def header(title)
  puts "~ #{title} ~"
  puts DASHED_LINE
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
  puts "            ~ Let's play #{GAME_TITLE}! ~"
  puts NEW_LINE
  puts "Get the sum of your cards close to or equal to #{WINNING_SUM}."
  puts "If you go over #{WINNING_SUM} or the dealer is closer, you lose!"
  puts NEW_LINE
  continue?
  system 'clear'
end
# rubocop:enable Metrics/MethodLength

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def deal_two_cards!(deck, data)
  data.each do |_, hash|
    hash[:cards] = Array.new(2) { deck.pop }
  end
end

def deal_next_card!(deck, name, data)
  data[name][:cards] += Array.new(1) { deck.pop }
end

def print_card_names(name, data)
  data[name][:cards].each_with_index do |card, ind|
    puts "Card #{ind + 1}: #{card[1]} of #{card[0]}"
  end
end

def correct_for_ace!(card_values, sum)
  card_values.select { |value| value == "Ace" }.count.times do
    sum -= 10 if sum > WINNING_SUM
  end
  sum
end

def calculate_total(name, data)
  sum = 0
  values = data[name][:cards].map do |card|
    card[1]
  end

  values.each do |value|
    sum += if value == "Ace"
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
  end
  sum = correct_for_ace!(values, sum)
  data[name][:total] = sum
end

def display_total(name, data= { dealer: { total: '?' } })
  header "#{name.to_s.capitalize} Total = #{data[name][:total]}"
end

def display_points(data)
  puts NEW_LINE
  print "     "
  header "Points"
  data.each do |name, hash|
    puts "#{name.to_s.capitalize} = #{hash[:score]}"
  end
  puts DASHED_LINE
end

def display_dealer_cards(data, hidden)
  if hidden
    display_total(:dealer)
    hide_cards(:dealer, data)
  else
    display_total(:dealer, data)
    print_card_names(:dealer, data)
  end
  data
end

def display_table(data, hidden= true)
  puts NEW_LINE
  display_dealer_cards(data, hidden)
  puts NEW_LINE

  display_total(:player, data)
  print_card_names(:player, data)
  display_points(data)
  puts NEW_LINE
end

def hide_cards(name, data)
  data[name][:cards].each_index do |ind|
    if ind == 0
      visible_card = data[name][:cards][0]
      puts "Card #{ind + 1}: #{visible_card[1]} of #{visible_card[0]}"
    else
      print "Card #{ind + 1}: ?\n"
    end
  end
end

def player_turn(deck, data)
  loop do
    answer = hit_or_stay?
    if answer == 'hit'
      deal_next_card!(deck, :player, data)
      calculate_total(:player, data)
      display_table(data)
      break if busted?(data)
    else
      display_table(data)
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

def dealer_turn(deck, data)
  while data[:dealer][:total] < STAY
    deal_next_card!(deck, :dealer, data)
    calculate_total(:dealer, data)
    system 'clear'
    display_table(data)
    sleep(1.7)
  end
end

def busted?(data)
  data[:player][:total] > WINNING_SUM || data[:dealer][:total] > WINNING_SUM
end

def stay_and_continue(name)
  puts "#{name.to_s.capitalize} chooses to stay!"
  puts NEW_LINE
  continue?
end

def determine_round_winner(data)
  if data[:dealer][:total] > WINNING_SUM
    :dealer_busted
  elsif data[:player][:total] > WINNING_SUM
    :player_busted
  elsif data[:dealer][:total] > data[:player][:total]
    :dealer
  elsif data[:dealer][:total] < data[:player][:total]
    :player
  else
    :tie
  end
end

def display_winner(result)
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

def display_game_winner(data)
  if data[:player][:score] == WINNING_POINTS
    puts "Player won #{WINNING_POINTS} rounds!"
    puts DASHED_LINE
    true
  elsif data[:dealer][:score] == WINNING_POINTS
    puts "Dealer won #{WINNING_POINTS} rounds!"
    puts DASHED_LINE
    true
  end
end

def update_points(winner, data)
  case winner
  when :player_busted
    data[:dealer][:score] += 1
  when :dealer_busted
    data[:player][:score] += 1
  when :dealer
    data[:dealer][:score] += 1
  when :player
    data[:player][:score] += 1
  when :tie
    data
  end
end

def play_again?
  loop do
    print "Play again? (y/n) => "
    answer = gets.chomp
    return true if answer == 'y'
    return false if answer == 'n'
  end
end

def reset_score(data)
  data.each do |name, _|
    data[name][:score] = 0
  end
end

system 'clear'
game_intro
game_data = { player: { cards: [],
                        total: 0,
                        score: 0 },
              dealer: { cards: [],
                        total: 0,
                        score: 0 } }

loop do
  system 'clear'
  deck = initialize_deck

  deal_two_cards!(deck, game_data)

  calculate_total(:player, game_data)
  calculate_total(:dealer, game_data)

  display_table(game_data)
  
  loop do
    player_turn(deck, game_data)
    busted?(game_data) ? break : stay_and_continue(:player)
    system 'clear'
    display_table(game_data)

    dealer_turn(deck, game_data)
    busted?(game_data) ? break : stay_and_continue(:dealer)

    break
  end
  system 'clear'
  result = determine_round_winner(game_data)
  update_points(result, game_data)

  system 'clear'
  display_table(game_data, false)
  display_winner(result) unless display_game_winner(game_data)

  break unless play_again?

  reset_score(game_data) if display_game_winner(game_data)
end

puts NEW_LINE
puts "Thanks for playing #{GAME_TITLE}! Good bye!"
