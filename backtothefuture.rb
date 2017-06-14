#!/usr/bin/ruby

class BackToTheFuture
   def when method, &block
     # class_name = name.partition('.').first
     # method_name = name.partition('.').last
     object = method.first
     method_name = method.last

     # TracePoint.trace(:call) do |t|
     TracePoint.trace(:return) do |t|
       block.call if t.method_id == method_name && t.binding.receiver == object
     end
   end
end
