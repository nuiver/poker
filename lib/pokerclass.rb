class Hand

	SUITS = ["S","H","C","D"]
	VALUES = ["2","3","4","5","6","7","8","9","X","J","Q","K","A"]
	@@cards = []
	RANKS = {
    straight_flush:  90,
    four_of_a_kind:  80,
    full_house:      70,
    flush:           60,
    straight:        50,
    three_of_a_kind: 40,
    two_pair:        30,
    pair:            20
  }
  @score = 0
  @highest_card = nil

	def initialize(hand)

		@array_of_suits = [ hand[1], hand[4], hand[7], hand[10], hand[13] ]
		@array_of_values = [ hand[0], hand[3], hand[6], hand[9], hand[12] ]
		
		@hand = hand

		hand.split(" ").each do |i|
			@@cards << i
		end
	
	end

	def validate
		@suits_and_value_validation = true

		if @@cards.uniq.length == @@cards.length 
			puts "No duplicates in this hand: #{@hand}."
		else
			puts "Warning! Duplicates in this hand found: #{@hand}"
			@suits_and_value_validation = false
			return false
		end

		@@cards.each do |i|	
			unless SUITS.include?(i[1])
				puts "Invalid suit found: #{i}"
				@suits_and_value_validation = false
				return false
			end
			unless  VALUES.include?(i[0])
				puts "Invalid value found: #{i}"
				@suits_and_value_validation = false
				return false
			end
		end
		puts "All valid cards." if @suits_and_value_validation == true
		return true
	end

	def x_of_a_value?(x)
		x_of_a_value_test = false
		@array_multiple = @array_of_values.select{ |e| @array_of_values.count(e) > 1 }.uniq
		@array_multiple.each do |i|
			x_of_a_value_test = true if @array_of_values.count(i) == x
		end
		x_of_a_value_test
	end

	def flush?
		@array_of_suits.uniq.length == 1 ? true : false
	end

	def straight?
		@array_of_values_sorted = @array_of_values.sort_by { |e| VALUES.index(e) }
		i = VALUES.index( @array_of_values_sorted[0] )
		@array_of_values_sorted[0..4] == VALUES[i..(i+4)] ? true : false
	end

	def two_pair?
		@array_multiple.length == 2 && x_of_a_value?(3) == false ? true : false
	end

	def pair?
		@array_multiple.length == 1 && x_of_a_value?(3) == false ? true : false
	end

	def highest_card
		@array_of_values_sorted = @array_of_values.sort_by { |e| VALUES.index(e) }
		@highest_card = VALUES.index( @array_of_values_sorted[4] )
	end

	def analyze
		#royal flush
		if flush? && straight?
			"Straight flush"
		elsif x_of_a_value?(4)
			"4 of a kind"
		elsif x_of_a_value?(2) && x_of_a_value?(3)
			"Full house"
		elsif flush?
			"Flush"
		elsif straight?
			"Straight"
		elsif x_of_a_value?(3)
			"Thee of a kind"
		elsif two_pair?
			"Two pair"
		elsif pair?
			"Pair"
		else
			highest_card
			"The highestcard is #{@array_of_values_sorted[4]}."
		end
	end

	def score
		if flush? && straight?
			@score = RANKS[:straight_flush]
		elsif x_of_a_value?(4)
			@score = RANKS[:four_of_a_kind]
		elsif x_of_a_value?(2) && x_of_a_value?(3)
			@score = RANKS[:full_house]
		elsif flush?
			@score = RANKS[:flush]
		elsif straight?
			@score = RANKS[:straight]
		elsif x_of_a_value?(3)
			@score = RANKS[:three_of_a_kind]
		elsif two_pair?
			@score = RANKS[:two_pair]
		elsif pair?
			@score = RANKS[:pair]
		else
			@score = highest_card 	
		end
	end

end
