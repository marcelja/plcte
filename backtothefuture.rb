#!/usr/bin/ruby

class WhenCase
  attr_accessor :object, :method, :times

  def initialize object, method, props
    @object = object
    @method = method
    @times = 1

    if props.key?(:times)
      @times = props[:times]
    end
  end

  def compare_method object, method
    if @object == object && @method == method
      @times -= 1
    end
    @times == 0
  end
end

class WhenStatement
  attr_accessor :when_cases, :block, :args, :repeat

  def initialize(args, &block)
  @repeat = false
	@args = args
	@block = block
    parse
  end
  
  def parse
	@when_cases = []
  if @args.last == :repeat
    @args.pop
    @repeat = true
  end
    @args.each do |a|
      props = {}
      if a.length == 3
        props = a[2]
      end
      when_case = WhenCase.new(a[0], a[1], props)
      @when_cases.push(when_case)
    end
  end

  def compare_methods object, method
    return if @when_cases.empty?
    @when_cases.delete_if do |c|
      c.compare_method object, method
    end
    if @when_cases.empty?
      @block.call
	  parse if @repeat
    end
  end
end
      
class BackToTheFuture
  attr_accessor :when_stmts

   def initialize
    @when_stmts = []
     TracePoint.trace(:return) do |t|
       @when_stmts.each do |w|
         w.compare_methods t.binding.receiver, t.method_id
       end
     end
   end

   def when(*args)
     unless check_args(args)
       puts "wrong args"
       return
     end
     when_statement = WhenStatement.new(args) { yield }
     @when_stmts.push(when_statement)
   end

   def check_args(*args)
     true
   end
end
