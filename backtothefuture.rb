#!/usr/bin/ruby

class BackToTheFuture
   def when object, method

     # TracePoint.trace(:call) do |t|
     TracePoint.trace(:return) do |t|
       if t.method_id == method && t.binding.receiver == object
         yield
       end
     end
   end
end
