# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# ENUMERABLE METHODS: Own implementation of enumerable methods behaviour
module Enumerable
  # sm_each: implement the enumerable 'each'
  # yields: 'value' to the block
  def sm_each
    # return to_enum(:sm_each) unless block_given?
    arr = self if instance_of?(Array)
    arr = to_a if instance_of?(Range)
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    self
  end

  # sm_each_with_index: implement the enumerable 'each_with_index'
  # yields: 'index' & 'value' to the block
  def sm_each_with_index
    return to_enum(:sm_each_with_index) unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  # sm_select: implement the enumerable 'select'
  # yields: Array of value selected on executing the block statements
  def sm_select
    return to_enum(:sm_select) unless block_given?

    temp = []
    sm_each { |x| temp.append(x) if yield(x) }
    temp
  end

  # sm_all?: implement the enumerable 'all?'
  # yields: returns False / TRUE if 'all' elements match conditional filter
  def sm_all?(default = nil)
    # Check the TYPE of argument received : block, class, array etc
    if block_given?
      sm_each { |enum| return false if yield(enum) == false }
    elsif default.is_a? Class
      sm_each { |enum| return false unless enum.is_a? default }
    elsif default.is_a? Regexp
      sm_each { |enum| return false unless default.match(enum) }
    elsif default.nil?
      sm_each { |enum| return false unless enum }
    else
      return "Case: didn't handle yet."
    end
    # after all cases are handled to return true implicitly
    true
  end

  # sm_any: implement the enumerable 'any?'
  # yields: returns False / TRUE if 'any' elements match conditional filter
  def sm_any?(default = nil)
    # Check the TYPE of argument received : block, class, array etc
    if block_given?
      sm_each { |enum| return true if yield(enum) == true }
    elsif default.is_a? Class
      sm_each { |enum| return true unless enum.is_a? default }
    elsif default.is_a? Regexp
      sm_each { |enum| return true if default.match(enum) }
    elsif default.nil?
      sm_each { |enum| return true unless enum }
    else
      return "Case: didn't handle yet."
    end
    # after all cases are handled to return false implicitly
    false
  end

  # sm_none: implement the enumerable 'none?'
  # yields: returns False / TRUE if 'none of the' elements match conditional filter
  def sm_none?(default = nil)
    # Check the TYPE of argument received : block, class, array etc
    if block_given?
      sm_each { |enum| return false if yield(enum) == true }
    elsif default.is_a? Class
      sm_each { |enum| return false if enum.is_a? default }
    elsif default.is_a? Regexp
      sm_each { |enum| return false if default.match(enum) }
    elsif default.nil?
      sm_each { |enum| return false if enum }
    else
      return "Case: didn't handle yet."
    end
    # after all cases are handled to return false return true implicitly
    true
  end

  # sm_count: implement the enumerable 'count'
  # yields: 'counts' matching items to the given block
  def sm_count
    return to_enum(:sm_count) unless block_given?

    count = 0
    sm_each { |enum| count += 1 if yield(enum) }
    count
  end

  # sm_map: implement the enumerable 'map'
  # yields: returns and ARRAY executing each item with given block
  def sm_map(proc = nil)
    return to_enum(:sm_map) unless block_given? || proc

    map_arr = []
    if proc
      sm_each { |enum| map_arr.append(proc.call(enum)) }
    else
      sm_each { |enum| map_arr.append(yield(enum)) }
    end

    map_arr
  end

  # sm_inject: performs the actions like inject/reduce methods
  # yields: final total/string result of the BLOCK processed or Symbols
  def sm_inject(collect = nil)
    if block_given?
      sm_each do |enum|
        collect = collect.nil? ? enum : yield(collect, enum)
      end
    end
    collect
  end
end

def multiply_els(arr)
  # Can Provide the BLOCK
  out = (arr.sm_inject { |result, element| (result * element) })
  p out
end
numbers = [2, 4, 5]
multiply_els(numbers)

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
