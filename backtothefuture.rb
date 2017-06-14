#!/usr/bin/ruby

class BackToTheFuture
  @@classlist = []
   def when method_name
     puts "TEST TEST"
     puts method_name
   end

   def new class_name
     add_class class_name
   end

   def add_class class_name
     # class_name.class_eval {def bar; puts 123; end}
     new_class = Class.new
     @@classlist.push([new_class, class_name])
     class_name.instance_methods(false).each { |x| add_method new_class, x }
     print_classes
     puts new_class.methods(false)
     new_class
   end

   def add_method new_class, method_name
     new_class.define_singleton_method(method_name) do
       puts "YOASUFUO"
     end
   end

   def print_classes
     @@classlist.each { |x| puts "  " + x.to_s }
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
ttt = b.new TestClass
ttt.method1
