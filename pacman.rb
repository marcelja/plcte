#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class PacMan
  def eat_dot
    puts "Eat dot."
  end

  def hit_ghost
    puts "Hit ghost."
	if has_occurred :any, :eat_dot
		puts 'amazing'
	end
  end

  def eat_ghost
    puts "Eat ghost."
  end

  def die
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
