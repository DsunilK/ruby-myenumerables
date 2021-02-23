
#spec/myenumerables_spec.rb

require 'rspec'
require_relative '../myenumerables.rb'

ARRAY_SIZE = 10
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'Enumerable Module' do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) } }
  let!(:array_clone) { array.clone }
  
  describe "RSPEC# - Method: #my_each"  do
    it '1. returns an Enumerator if no block is given' do
      expect(array.my_each).to be_an(Enumerator)
    end

    it '2. does not mutate the original array' do
      array.my_each { |num| num + 1 }
      expect(array).to eq(array_clone)
    end    

    it '3. returns an Enumerator after applying the block given ' do
      block = proc { |x| x + 2 }
      out_my_each = array.my_each(&block)
      out_each = array.each(&block)
      expect(out_my_each).to eq(out_each)
    end
  end

  describe "RSPEC# - Method: #my_each_with_index"  do
    it '1. returns an enumerator if no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end

    it '2. does not mutate the original array' do
      array.my_each_with_index { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

  end




  describe "RSPEC# - Method: #my_inject"  do
    it '1. raises a "LocalJumpError" when no block or argument is given' do
      expect { array.my_inject }.to raise_error(LocalJumpError)
    end
  end 
  
  describe 'RSPEC# #multiply_els' do
    it '1. accepts an array as an argument and multiplies all the elements of the array together using #my_inject' do
      actual = multiply_els [2, 4, 5]
      expect(actual).to eq 40
    end
  end

end
