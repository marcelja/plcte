#!/usr/bin/ruby
require 'pry'
require_relative 'backtothefuture.rb'

class TestClass
  def method1
    puts "Method1 running..."
  end

  def method2
  end

  def method3
  end
end

test = TestClass.new

# Example 1
when_returned [test, :method1] { puts "Method1 was called." }

# Example 2
when_returned [test, :method1, {times: 5}] { puts "Method1 was called 5 times." }

# Example 3
when_returned [test, :method1], [test, :method2] { puts "M1 and M2 were called." }

# Example 4
when_returned [test, :method3, {times: 2}], :repeat { puts "bla" }

# Example 5
# in_last_seconds 5, test, :method1

binding.pry
