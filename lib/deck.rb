require_relative 'my_card'
require 'byebug'

class Deck
  
  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards << Card.new(:no_suit, :joker) << Card.new(:no_suit, :joker)
  end
  
  def initialize(cards = Deck.all_cards)
    @cards = cards
  end
  
  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    if count < n
      raise ArgumentError.new "Deck does not have enough cards, try again."
    end
    @cards.shift(n)
  end
  
  def empty?
    @cards.empty?
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards.concat(cards)
  end
  
  def shuffle!
    @cards.shuffle!
  end
  
end