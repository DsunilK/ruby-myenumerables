# frozen_string_literal: true
#
module Enumerable
  # Nothing
  def nothing
    yield nil
  end

  # each: implement the enumerable 'each'
  # yields: 'value' to the block
  # TEST : -------------------------------
  # arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  # arr.sm_each do |value|
  #   p value
  # end
  def sm_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end

  # each_with_index: implement the enumerable 'each_with_index'
  # yields: 'index' & 'value' to the block
  # TEST : -------------------------------
  # arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  # arr.sm_each do |value, index|
  #   p "Index: #{index+1} Value. #{value}"
  # end
  def sm_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end

  # sm_select: implement the enumerable 'select'
  # yields: Array, after selecting value after executing the block statements
  def sm_select
    temp=[]
    i = 0
    while i < self.length
        temp.append(self[i]) if yield(self[i])
      i += 1
    end
    temp
  end

  # sm_all?: implement the enumerable each
  # yields: Boolean, if result is TRUE after executing the block statements
  def sm_all?
    sm_each { |enum| return false if yield(enum) == false }
    return true
  end

end
