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
    return dup unless block_given? || param.is_a?(Proc)

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

exmaplearr = [4, 5, 6, 7]
exmaplearr.my_each { |x| puts x + 2 }
[4, 5, 6, 7].my_each { |x| puts x + 3 }
p exmaplearr.my_each
newarr = exmaplearr.my_select { |num| num > 5 }
p newarr
maparr = exmaplearr.my_map
maparr2 = exmaplearr.my_map { |x| x**2 }
p maparr
p maparr2
strings = %w[bacon orang apple]
puts 'yey' if strings.my_all? { |str| str.length == 5 }
# Initialize an enumerable
enu1 = [10, 19, 18]

# checks if all numbers are greater
# than 4 or not
res1 = enu1.my_all? { |num| num > 4 }

# prints the result
puts res1

# ch__LINE__ecks if all numbers are greater
# than 4 or not
res2 = enu1.my_all? { |num| num >= 15 }

# prints the result
puts res2
# Initialize an enumerable
enu3 = [10, 19, 20]

# Checks
res3 = enu3.my_all?(Numeric)

# prints the result
puts res3

# Initialize
enu4 = [nil, nil]

# Checks
res4 = enu4.my_all?
# prints the result
puts res4

p 10.class

# Initialize
enu10 = [12, 18]

# returns enumerator
res10 = enu10.my_count
p res10
# Ruby program for count method in Enumerable

# Initialize
enu11 = [12, 18, 2]

# returns enumerator
res11 = enu11.count(12)
p res11

# Ruby program for count method in Enumerable

# Initialize
enu12 = [12, 18, 16, 18]

# returns enumerator
res12 = enu12.count { |el| el > 13 }
p res12

p([3, 6, 10].my_inject { |sum, number| sum + number })
p [3, 6, 10, 13].inject(:+)

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/ModuleLength
