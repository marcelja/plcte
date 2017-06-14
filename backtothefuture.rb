#!/usr/bin/ruby
require 'pry'

class BackToTheFuture
   def when name, &block
     class_name = name.partition('.').first
     method_name = name.partition('.').last

     # TracePoint.trace(:call) do |t|
     TracePoint.trace(:return) do |t|
       block.call if t.method_id.to_s == method_name && t.defined_class.name == class_name
     end
   end
end

class TestClass
  def method1
    puts "bla"
  end

  def method2
    puts "blu"
  end
end

b = BackToTheFuture.new
test = TestClass.new

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
