#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class Account
  def initialize
    @state = :waiting 
    ### implement here unless beginner
    @counter = 0
    ########
  end

  def login password
    if @state == :waiting
      password == "1234" ? correct : wrong
    elsif @state == :loggedin
      puts "Already logged in."
    else
      puts "Account locked!"
    end
  end

  def lock
    puts "Account locked!"
    @state = :locked
  end

  def correct
    puts "Logged in."
    @state = :loggedin
  end

  def wrong
    puts "Wrong password!"
    ### implement here
    @counter = @counter + 1
    if @counter == 3
      lock
    ########
  end
end

account = Account.new

binding.pry
