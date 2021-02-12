# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/ModuleLength

# MY ENUMERABLES
module Enumerable
  # each
  def my_each(&block)
    return enum_for(:each) unless block_given?

    each(&block)
  end

  # my_each_with_index
  def my_each_with_index
    return enum_for(:each) unless block_given?

    myindex = 0
    each do |i|
      yield i, myindex
      myindex += 1
    end
  end

  # my_select
  def my_select
    return enum_for(:each) unless block_given?

    selected = []
    each do |i|
      selected.push(i) if yield i
    end
    selected
  end

  # my_all? ------------
  def my_all?(parameter = nil)
    my_each do |x|
      if block_given?
        return false unless yield x
      elsif parameter.is_a?(Regexp)
        return false unless parameter.match?(x)
      elsif parameter.is_a?(Class)
        return false unless x.is_a?(parameter)
      else
        return false unless x
      end
    end
    true
  end

  # my_any?
  def my_any?(parameter = nil)
    my_each do |x|
      if block_given?
        return true if yield x
      elsif parameter.is_a?(Class)
        return true if x.is_a?(parameter)
      elsif parameter.is_a?(Regexp)
        return true if parameter.match?(x)
      elsif x
        return true
      end
    end
    false
  end

  # my_none?
  def my_none?(parameter = nil)
    my_each do |x|
      if block_given?
        return false if yield x
      elsif parameter.is_a?(Class)
        return false if x.is_a?(parameter)
      elsif parameter.is_a?(Regexp)
        return false if parameter.match?(x)
      elsif x
        return false
      end
    end
    true
  end

  # my_count
  def my_count(parameter = nil)
    res = 0
    my_each do |x|
      if block_given?
        res += 1 if yield x
      elsif parameter.nil?
        res += 1
      elsif parameter == x
        res += 1
      end
    end
    res
  end

  # my_map
  def my_map(param = nil)
    return to_enum(:my_map) unless block_given? || param

    retarr = []
    my_each do |x|
      if param.is_a?(Proc)
        retarr.push(param.call(x))
      else
        retarr.push(yield x)
      end
    end
    retarr
  end

  # my_inject
  def my_inject(initial = nil, sym = nil)
    raise LocalJumpError if initial.nil? && sym.nil? && !block_given?

    if initial.is_a? Symbol
      sym = initial
      initial = nil
    end
    if is_a? Array
      if block_given?
        accum = if initial.nil?
                  self[0]
                else
                  yield(initial, self[0])
                end
      end
      unless sym.nil?
        accum = if initial.nil?
                  self[0]
                else
                  initial.public_send(sym, self[0])
                end
      end

      x = 1
      while x < length
        accum = accum.public_send(sym, self[x]) unless sym.nil?
        accum = yield accum, self[x] if block_given?
        x += 1
      end
    end
    if is_a? Range
      if block_given?
        accum = if initial.nil?
                  self.begin
                else
                  yield(initial, self.begin)
                end
      end
      unless sym.nil?
        accum = if initial.nil?
                  self.begin
                else
                  initial.public_send(sym, self.begin)
                end
      end

      x = Range.new(self.begin + 1, self.end)
      x.each do |i|
        accum = accum.public_send(sym, i) unless sym.nil?
        accum = yield accum, i if block_given?
      end
    end
    accum
  end
end

def multiply_els(arr)
  # Can Provide the BLOCK
  out = (arr.my_inject { |result, element| (result * element) })
  p out
end
numbers = [2, 4, 5]
multiply_els(numbers)

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/ModuleLength
