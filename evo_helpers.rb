#!/usr/bin/ruby

module EvoHelpers 
  # generates random chromosome of 0's and 1's. not very creative, will on average be 50/50 ratio
  def random_chromosome
    Array.new(32).collect {|e| e = rand 2}
  end

  # fitness function
  # returns frequency of 1's in the array -- we'll use this as a basic scoring mechanism
  def calc_fitness(member)
    member.collect {|e| e if e == 1}.compact.size
  end

  # ZOMGSEX!1
  # concatonates first half of chromo1 to second half of chromo2 with single mutation
  def mate(chromo1, chromo2)
    mutate(chromo1.first(16) + chromo2.last(16))
  end

  # mutates two values in chromosome
  def mutate(chromo)
    2.times { chromo[rand 32] = rand 2}
    chromo
  end

  # returns top 10 fittest members
  def alphas(arrs)
    tmp = []
    arrs.each_index {|i| tmp << [calc_fitness(arrs[i]),i]}
    tmp.sort!.reverse!.collect {|e| arrs[e[1]]}.first 10
  end

  def print_alpha_stats(arr)
    arr.each {|a| puts "#{a.inspect}, fitness: #{calc_fitness(a)}"}
    puts ""
  end
end

# open up array class to add several convenience methods!
class Array
  def random
    self[rand self.size]
  end

  def is_spartan?
    self == (Array.new(32).fill 1)
  end
end
