require_relative 'deck'
require_relative 'hand'
require 'byebug'

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
  end
  
  def display_hand
    @hand.to_s
  end
  
  def chosen_card(card_num)
    @hand.cards[card_num]
  end

end

class Game
  
  attr_reader :players, :deck

  def initialize
    @players = []
    reset_deck
    @scores = {}
    @joker = false
  end
  
  def reset_deck
    @deck = Deck.new
    @deck.shuffle!
    set_top_card
  end
  
  def set_top_card
    loop do
      @top_card = @deck.take(1).first
      break unless [:joker, :eight].include?(@top_card.value)
      @deck.return([@top_card])
    end
  end
  
  def play
    add_players
    until game_over?
      p "Round began!"
      deal_cards
      round_over = false
      until round_over
        @players.each do |player|
          player_turn(player)
          if player.hand.empty?
            round_over = true
            p "#{player.name} won the round!"
            update_scores(player)
            break
          end
        end
      end
      p "Scores"
      @scores.each { |player, score| p "#{player.name} - #{score}" }
      reset_deck
      @players.shuffle!
    end
  end
  
  def add_players
    p "How many players, (up to 5):"
    input = gets.chomp.to_i
    input.times do |i|
      @players << Player.new("Player #{i}")
      @scores[@players.last] = 0
    end
  end
  
  def deal_cards
    @players.each do |player|
      player.hand = Hand.deal_from(@deck)
    end
  end
  
  def game_over?
    max_points = 100 + (@players.count - 2) * 50
    @scores.each do |player, score|
      if score >= max_points
        p "#{player.name} won the game!"
        return true
      end
    end
    false
  end
  
  def player_turn(player)
    puts
    p "#{player.name}'s turn."
    p "Top card: #{@top_card}"
    p "Your hand"
    player.display_hand
    @deck.empty? ? (p "Would you like to discard(1), or pass(3)?") : (p "Would you like to discard(1), or draw(2)?")
    answer = gets.chomp.to_i
    case answer
    when 1
      if player.hand.cards.any? { |c| valid_discard?(c) }
        discard(player)
      else
        p "You can't discard, draw instead."
        draw(player)
      end
    when 2
      draw(player)
    end
  end
  
  def update_scores(winner)
    @scores.each { |player, score| @scores[winner] += player.hand.points }
  end
  
  def discard(player)
    begin
      p "Which card number would you like to discard?"
      card_ind = gets.chomp.to_i
      card = player.chosen_card(card_ind)
      if !valid_discard?(card)
        raise ArgumentError.new "You cannot discard that card"
      end
    rescue ArgumentError => e
      p e.message
      retry
    end
    @top_card = card
    special_card_actions(card)
    player.hand.discard_card(card_ind)
  end
  
  def draw(player)
    until @deck.empty?
      drawn = @deck.take(1).first
      p "You drew a #{drawn}"
      if valid_discard?(drawn)
        p "#{drawn} is a valid discard."
        @top_card = drawn
        special_card_actions(drawn)
        return
      end
      player.hand.cards << drawn
    end
    p "The deck is empty."
  end
  
  def valid_discard?(card)
    return true if card.suit == @top_card.suit || @joker
    case card.value
    when @top_card.value
      return true
    when :eight
      return true
    when :joker
      return true
    else
      return false
    end
  end
  
  def special_card_actions(card)
    @joker = false if @joker
    case card.value
    when :eight
      choose_next_suit
    when :joker
      @joker = true
    end
  end
  
  def choose_next_suit
    p "What would you like the next suit to be?"
    next_suit = gets.chomp.to_sym
    @top_card.suit = next_suit
  end
  
end

g = Game.new
g.play