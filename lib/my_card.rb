# -*- coding: utf-8 -*-

# Represents a playing card.
class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  CRAZYEIGHTS_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 50,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => 10,
    :joker => 10
  }
  
  def self.suits
    SUIT_STRINGS.keys
  end
  
  def self.values
    VALUE_STRINGS.keys
  end
  
  attr_accessor :suit, :value
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
    
  def point_value
    CRAZYEIGHTS_VALUE[@value]
  end
  
  def to_s
    return "JJ" if @suit == :no_suit
    VALUE_STRINGS[value] + SUIT_STRINGS[suit]
  end
  
end
