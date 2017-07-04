#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class Account
  def initialize
    @state = :waiting 
    # TODO
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
    # TODO
  end
end

account = Account.new

# when_returned [account, :wrong, {times: 3}] do
#   account.lock
# end

# TODO

binding.pry
