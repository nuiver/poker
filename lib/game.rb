require 'pokerclass'

class Game

	class ConfigActions
		@@actions =['play', 'quit']
		def self.actions; @@actions; end
	end

	def initialize

	end

	def launch!
		intro
		result = nil
		until result == :quit
			action = get_action
			result = do_action(action)
		end
	end

	def get_action
		action = nil
		until Game::ConfigActions.actions.include?(action)
			puts "Type: " + Game::ConfigActions.actions.join(", ")
			print "> "
			action = gets.chomp.downcase
		end
		return action
	end

	def do_action(action)
		case action
		when	'play'
			create_hands
			play_round
		when 'quit'
			return :quit
		else
			puts "Try again..."
		end
	end

	def intro
		puts "Hello, let's play!"
	end

	def generate_hand
		deck = ["AC", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "XC", "JC", "QC", "KC", "AH", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "XH", "JH", "QH", "KH", "AS", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "XS", "JS", "QS", "KS", "AD", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "XD", "JD", "QD", "KD"]
		hand = []
		5.times do
			hand << (deck - hand).sample
			hand << " "
		end
		hand.pop
		return hand
	end

	def create_hands
		@hand_one = generate_hand.join("")
		@hand_two = generate_hand.join("")
	end

	def play_round
		puts "One hand has #{@hand_one}."
		puts "Hand two has #{@hand_two}."
		one = Hand.new(@hand_one)
		two = Hand.new(@hand_two)
		puts "One hand has #{one.analyze}."
		puts "Hand two has #{two.analyze}."
		if (one.score <=> two.score) == 1
			puts "Hand 1 has won"
		elsif (one.score <=> two.score) == -1
			puts "Hand 2 has won"
		else
			puts "Time to check the game rules...!"
		end
	end

end
