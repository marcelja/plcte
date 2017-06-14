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
    puts @object
    puts @method
    puts @times
  end

  def compare_method object, method
    # if method == :method1
    #   puts 123
    #   puts object
    #   puts @@object
    # end
      if method == :method1
        puts object
        puts @object
      end
    if @object == object && @method == method
      puts "-1"
      @times -= 1
    end
    @times == 0
  end
end

class WhenStatement
  attr_accessor :when_cases, :block

  def initialize(args, &block)
    @when_cases = []
    args.each do |a|
      props = {}
      if a.length == 3
        props = a[2]
      end
      when_case = WhenCase.new(a[0], a[1], props)
      @when_cases.push(when_case)
      @block = block
    end
  end

  def compare_methods object, method
    return if @when_cases.empty?
    @when_cases.delete_if do |c|
      c.compare_method object, method
    end
    if @when_cases.empty?
      @block.call
    end
  end
end
      
      

# class ObserveWhenStmt
#   def init args
#     args.each { |x| puts x }
#     puts '123'
#     yield
#     puts '456'
#   end
# 
#   def parse_methods args
# 
# end


class BackToTheFuture
    @@when_stmts = []
   def initialize
     TracePoint.trace(:return) do |t|
       @@when_stmts.each do |w|
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
     @@when_stmts.push(when_statement)
   end

   def check_args(*args)
     true
   end


     # when_stmt = ObserveWhenStmt.new
     # when_stmt.init(args) { yield }
     # @@when_stmts.push(when_stmt)


     # TracePoint.trace(:call) do |t|
     # TracePoint.trace(:return) do |t|
     #   if t.method_id == method && t.binding.receiver == object
     #     puts 'bla'
     #   end
     # end
end
