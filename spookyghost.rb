#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class PacMan
  def scared
    puts 'pacman is scared'
  end
  
  def afraid
    puts 'pacman is afraid'
  end
end

class SpookyGhost
  def scream
  end
end

p = PacMan.new
g1 = SpookyGhost.new
g2 = SpookyGhost.new
g3 = SpookyGhost.new
g4 = SpookyGhost.new
g5 = SpookyGhost.new

when_returned [g1, :scream], :repeat { p.afraid }

when_returned [:any, :scream], :repeat { p.scared }

binding.pry
