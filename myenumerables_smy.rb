# frozen_string_literal: true
#
module Enumerable
  # Nothing
  def nothing
    yield nil
  end

  # each: implement the enumerable each
  # yields: 'value' to the block
  # TEST : -------------------------------
  # arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  # arr.sm_each do |value|
  # puts value
  # TEST : -------------------------------
  def sm_each
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    self
  end

  # each_with_index: implement the enumerable each
  # yields: 'index' & 'value' to the block
  # TEST : -------------------------------
  # arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  # arr.sm_each do |value, index|
  #   puts "Index: #{index+1} Value. #{value}"
  # end
  # TEST : -------------------------------
  def sm_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

end
