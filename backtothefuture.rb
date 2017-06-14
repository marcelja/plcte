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
