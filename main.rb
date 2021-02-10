# frozen_string_literal: true

# Include Enumerable implementations & uncomment the 'require' statement below to test.
require './myenumerables_smy.rb'
# require './myenumerables_disc'

# does nothing
# nothing

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# one line version
# sm_each(arr)

arr.sm_each

# multi-line version
# arr.each do |number|
#   puts number
# end
