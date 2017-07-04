#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class SpaceInvaders
  attr_accessor :last_shot

  def initialize
    @last_shot = 0
  end

  def current_time
    # Return current time in seconds.
    Time.now.to_i
  end

  def shoot
    puts "Shoot"
    ### implement here unless beginner
    @last_shot = current_time
    ########
  end

  def request_shoot
    ### implement here unless beginner
    if ### implement here ### current_time - 3 < @last_shot
      puts "Can't shoot. Reloading.."
    else
      shoot
    end
    ########
  end
end

space_invaders = SpaceInvaders.new

binding.pry
