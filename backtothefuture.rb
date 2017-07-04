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
    if (@object == :any || @object == object) && @method == method
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

    if @args.last == :repeat
      @args.pop
      @repeat = true
    end
    parse
  end
  
  def parse
    @when_cases = []
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
  attr_accessor :when_stmts, :event_timestamps

  def initialize
    @when_stmts = []
    @event_timestamps = {}

    TracePoint.trace(:return) do |t|
      add_event_item t.binding.receiver, t.method_id

      @when_stmts.each do |w|
        w.compare_methods t.binding.receiver, t.method_id
      end
    end
  end

  def add_event_item object, method
    if @event_timestamps.has_key?(method)
      @event_timestamps[method][object.__id__] = Time.now.to_i
    else
      method_timestamp = {}
      method_timestamp[object.__id__] = Time.now.to_i
      @event_timestamps[method] = method_timestamp
    end
  end

  def when(*args)
    unless check_args(args)
      puts "wrong args"
      return
    end
    when_statement = WhenStatement.new(args) { yield }
    @when_stmts.push(when_statement)
    return true
  end

  def check_args(args)
    true
  end
  
  def has_occurred object, method
    return false unless @event_timestamps.has_key?(method)
    if object == :any
      executed_at = get_timestamp method
      return false if executed_at == -1
    else
      return false unless @event_timestamps[method].has_key?(object.__id__)
      executed_at = @event_timestamps[method][object.__id__]
    end
    return true
  end
  
  def in_last_seconds seconds, object, method
    return false unless @event_timestamps.has_key?(method)
    executed_at = 0
    if object == :any
      executed_at = get_timestamp method
      return false if executed_at == -1
    else
      return false unless @event_timestamps[method].has_key?(object.__id__)
      executed_at = @event_timestamps[method][object.__id__]
    end
    Time.now.to_i - executed_at <= seconds
  end
  
  def get_timestamp method
    return -1 if @event_timestamps[method].empty?
	
    max_stamp = -1
    @event_timestamps[method].each do |key, stamp|
      if stamp > max_stamp
        max_stamp = stamp
      end
    end
    return max_stamp
  end
  
  def destroy_all
    @when_stmts = []
    @event_timestamps = {}
  end
end

b = BackToTheFuture.new;

class Object
  def when_returned(*args)
    @@bttf.when(*args) { yield }
  end
  
  def has_occurred(*args)
    @@bttf.has_occurred(*args) { yield }
  end

  def in_last_seconds(*args)
    @@bttf.in_last_seconds(*args)
  end

  def initialize_backtothefuture
    @@bttf = BackToTheFuture.new
  end
end

initialize_backtothefuture
