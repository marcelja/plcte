#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class PacMan
  def eat_dot
    puts "Eat dot."
	when_returned [:any, :next_level, {times: 5}] { puts "awesome" }
  end

  def hit_ghost
    puts "Hit ghost."
  end

  def eat_ghost
    puts "Eat ghost."
  end

  def die
    if in_last_seconds 10, :any, :eat_dot
	  puts "foo"
	else
	  puts "bar"
	end
  end

  def next_level
    puts "You are now at the next level."
  end
end

p = PacMan.new

when_returned [p, :hit_ghost], :repeat do
  if in_last_seconds 10, :any, :eat_dot
    p.eat_ghost
  else
    p.die
  end
end

when_returned [p, :eat_dot, {times: 5}] { p.next_level }

binding.pry
