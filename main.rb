# frozen_string_literal: true

# Include Enumerable implementations & uncomment the 'require' statement below to test.
require './myenumerables_smy'
# require './myenumerables_disc'

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# when no block is specified it throws an error
# p arr.sm_each

# # Enumerable With a VALUE
# arr.sm_each do |value|
#   p value
# end

# # Enumerable with Index & Value
# arr.sm_each_with_index do |value, index|
#   p "Index: #{index+1} Value. #{value}"
# end

# # Enumerable with conditional filter that discards false check
# p arr.sm_select {|x| x>5 }

# Enumerable that returns TRUE if 'all' elements match conditional filter 
# p arr.sm_all? { |x| x < 11 }

# arr2 = %w[ant bear cat]
# p arr2.sm_all? { |word| word.length >= 3 } 

# arr3 = [1, 2, 3.14]
# p arr3.sm_all?(String)
# p arr3.sm_all?(Numeric)


# arr4 = [nil, true, 99]
# p arr4.sm_all?
# p [].sm_all?

# arr5 = %w[ant bear cat]
# arr5 = %w[ant bat cat]
# p arr5.sm_all?(/t/)




