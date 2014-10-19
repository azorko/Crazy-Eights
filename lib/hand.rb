require_relative 'deck'

class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(8))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    points = 0
    @cards.each { |card| points += card.point_value }
    points
  end

  def empty?
    @cards.empty?
  end

  def draw_card(deck)
    @cards.concat(deck.take(1))
  end
  
  def discard_card(card_ind)
    @cards.delete_at(card_ind)
  end

  def to_s
    @cards.each_with_index { |card, i| p "Card #{i}: " + card.to_s }
  end
end
