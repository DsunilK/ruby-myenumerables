
#spec/myenumerables_spec.rb

require 'rspec'
require_relative '../myenumerables.rb'

ARRAY_SIZE = 10
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'Enumerable Module' do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) } }
  let!(:array_clone) { array.clone }
  let(:words) { %w[string of words array] }
  let(:range) { Range.new(1, 10) }

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


  describe 'RSPEC# - Method: #my_select' do
    block = proc { |x| x > 2 }
    it '1. I/P-Array: returns an Enumerator with elements for which the given block returns a true value ' do
      expect(array.my_select(&block)).to eq(array.select(&block))
    end

    it '2. I/P-Range: returns an Enumerator with elements for which the given block returns a true value' do
      expect(range.my_select(&block)).to eq(range.select(&block))
    end

    it '3. returns an enumerator if no block is given' do
      expect(array.my_select).to be_an(Enumerator)
    end

    it '4. does not mutate the original array' do
      array.my_select { |num| num + 1 }
      expect(array).to eq(array_clone)
    end
  end
  
  describe 'RSPEC# - Method: #my_map' do
    let(:block) { proc { |x| x + 2 } }

    it '1. Returns Enumerator after applying the block given to each element of enum' do
      expect(array.my_map(&block)).to eq array.map(&block)
    end

    it '2. does not mutate the original array' do
      array.my_map { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

  end

  describe "RSPEC# - Method: #my_inject"  do
    it '1. raises a "LocalJumpError" when no block or argument is given' do
      expect { array.my_inject }.to raise_error(LocalJumpError)
    end
  
    it '2. does not mutate the original array' do
      array.my_inject { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

    context 'A. Context: when a symbol is specified with an initial value' do
      it '1. Combines array elements applying the symbol to inject method' do
        expect(array.my_inject(2, :+)).to eq array.inject(2, :+)
      end

      it '2. Combines range elements applying the symbol to inject method' do
        expect(range.my_inject(2, :+)).to eq range.inject(2, :+)
      end
    end

    context 'B. Context: when a symbol is specified without an initial value' do
      it '1. Combines array elements applying the symbol to inject method' do
        expect(array.my_inject(:+)).to eq array.inject(:+)
      end

      it '2. Combines range elements applying the symbol to inject method' do
        expect(range.my_inject(:+)).to eq range.inject(:+)
      end
    end
  end

  describe 'RSPEC# #multiply_els' do
    it '1. accepts an array as an argument and multiplies all the elements of the array together using #my_inject' do
      actual = multiply_els [2, 4, 5]
      expect(actual).to eq 40
    end
  end
end
