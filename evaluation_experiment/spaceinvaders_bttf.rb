#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class SpaceInvaders
  def shoot
    puts "Shoot"
  end

  def request_shoot
    if ### implement here ###
      puts "Can't shoot. Reloading.."
    else
      shoot
    end
  end
end

space_invaders = SpaceInvaders.new

binding.pry
