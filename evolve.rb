#!/usr/bin/ruby
# exercise in genetic programming
# goal is to mate pairs of arrays until one reaches all 1's
# that is...
# 	1. start with 50, 32-member arrays with random 0's and 1's
# 	2. calculate fitness of each (scored by number of 1's)
# 	3. cross top 10 to form new arrays
# 	4. goto 2

require 'evo_helpers'
include EvoHelpers

start = Time.now
NUM_OFFSPRING = ARGV[0].to_i
SPARTAN = Array.new(32).fill 1
SEEDS = Array.new(NUM_OFFSPRING).collect {random_chromosome}
top10 = alphas(SEEDS)

i = 0
loop do
  case top10.include? SPARTAN
  when true
    winners = top10.collect {|a| a if a.is_spartan?}.compact
    puts "#{winners.size} member(s) reached spartan status!"
    puts "completed in #{Time.now - start} seconds"
    break
  else
    puts "*** ALPHAS FROM GENERATION: #{i} ***"
    offspring = []
    NUM_OFFSPRING.times do |j|
      offspring << mate(top10.random, top10.random)
    end 
    top10 = alphas(offspring)
    print_alpha_stats(top10)
    i += 1
  end
end
