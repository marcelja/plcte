#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

b = BackToTheFuture.new

class PacMan
  def eat_dot
    puts "Eat dot."
  end

  def hit_ghost
    puts "Hit ghost."
  end

  def eat_ghost
    puts "Eat ghost."
  end

  def die
    puts "You died."
  end

  def next_level
    puts "You are now at the next level."
  end
end

p = PacMan.new

b.when [p, :hit_ghost], :repeat do
  if b.in_last_seconds(10, p, :eat_dot)
    p.eat_ghost
  else
    p.die
  end
end

b.when [p, :eat_dot, {times: 5}] { p.next_level }

binding.pry
