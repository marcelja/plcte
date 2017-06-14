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

b.when ("TestClass.method1") { puts "blabla" }
a = 7

b.when ("TestClass.method2") do
  testvar = 12345
  puts testvar - 777
  puts "done"
  a = 55
  test.method1
end

binding.pry
# test.method1

