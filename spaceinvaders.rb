#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class SpaceInvaders
  attr_accessor :last_shot

  def initialize
    @last_shot = nil
  end

  def current_time
    Time.now.to_i
  end

  def shoot
    puts "Shoot"
    # TODO
  end

  def request_shoot
    unless in_last_seconds 3, self, :shoot
      shoot
    else
      puts "Can't shoot. Reloading.."
    end
  end
end

space_invaders = SpaceInvaders.new

binding.pry
