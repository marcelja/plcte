#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

b = BackToTheFuture.new

class TestClass
  def method1
    puts "bla"
    return 7
  end

  def method2
    puts "blu"
  end
end

test = TestClass.new
test1 = TestClass.new

b.when [test, :method1, {times: 2}] do
  puts "XZVCZCV"
end

b.when [test, :method1, {times: 2}], [test1, :method1] do
  puts "XZVCZCVASDFASDFASD"
end

binding.pry
# test.method1
