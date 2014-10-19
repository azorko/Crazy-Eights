#this is a test spec, not finished

require 'rspec'
require 'deck'

describe "Deck" do
  describe "#count" do
    let(:deck) { Deck.new }
    it "returns the number of cards in a deck with jokers" do 
      expect(deck.count).to eq(54)
    end
  
  end
end