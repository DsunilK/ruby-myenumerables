# frozen_string_literal: true

# spec/myenumerables_spec.rb
# rubocop:disable Metrics/BlockLength

require 'rspec'
require_relative '../myenumerables'

ARRAY_SIZE = 10
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'Enumerable Module' do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) } }
  let!(:array_clone) { array.clone }
  let(:words) { %w[string of words array] }
  let(:range) { Range.new(1, 10) }

  describe 'RSPEC# - Method: #my_each' do
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

  describe 'RSPEC# - Method: #my_each_with_index' do
    it '1. returns an enumerator if no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end

    it '2. does not mutate the original array' do
      array.my_each_with_index { |num| num + 1 }
      expect(array).to eq(array_clone)
    end
  end

  describe 'RSPEC# - Method: #my_select' do
    let(:block) { proc { |x| x > 2 } }
    let(:range) { Range.new(1, 10) }
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

  describe 'RSPEC# - Method: #my_all?' do
    let(:true_block) { proc { |num| num <= HIGHEST_VALUE } }
    let(:false_block) { proc { |num| num > HIGHEST_VALUE } }

    it '1. returns true if the block accepts all elements' do
      expect(array.my_all?(&true_block)).to eq(array.all?(&true_block))
    end

    it '2. returns false if the block rejects all elements' do
      expect(array.my_all?(&false_block)).to eq(array.all?(&false_block))
    end

    it '3. does not mutate the original array' do
      array.my_all? { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

    context 'A. when no block or argument is given' do
      let(:true_array) { [1, true, 'hi', []] }
      let(:false_array) { [1, false, 'hi', []] }
      it '1. returns true when none of the collection members are false or nil' do
        expect(true_array.my_all?).to be true_array.all?
      end

      it '2. returns false when one of the collection members are false or nil' do
        expect(false_array.my_all?).to be false_array.all?
      end
    end

    context 'B. When a condition is given' do
      it '1. returns true if all of the collection matches the condition' do
        array = []
        5.times { array << 3 }
        expect(array.my_all?(3)).to be array.all?(3)
      end

      it '2. returns false if any of the collection does not match the condition' do
        expect(array.my_all?(3)).to be array.all?(3)
      end
    end
  end

  describe 'RSPEC# - Method: #my_any?' do
    let(:true_block) { proc { |num| num <= HIGHEST_VALUE } }
    let(:false_block) { proc { |num| num > HIGHEST_VALUE } }
    it '1. returns true if the block ever returns a value other than false or nil' do
      expect(array.my_any?(&true_block)).to eq(array.any?(&true_block))
    end

    it '2. returns false if the block ever returns a value false or nil' do
      expect(array.my_any?(&false_block)).to eq(array.any?(&false_block))
    end

    it '3. does not mutate the original array' do
      array.my_any? { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

    context 'A. when no block or argument is given' do
      let(:true_array) { [nil, false, true, []] }
      let(:false_array) { [nil, false, nil, false] }
      it '1. returns true if at least one of the collection is not false or nil' do
        expect(true_array.my_any?).to be true_array.any?
      end

      it '2. returns false if at least one of the collection is not true' do
        expect(false_array.my_any?).to be false_array.any?
      end
    end

    context 'B. when a pattern other than Regex or a Class is given' do
      it '1. returns false if none of the collection matches the pattern' do
        expect(words.my_any?('flower')).to be words.any?('flower')
      end

      it '2. returns true if any of the collection matches the pattern' do
        words[0] = 'flower'
        expect(words.my_any?('flower')).to be words.any?('flower')
      end
    end
  end

  describe 'RSPEC# - Method: #my_none?' do
    let(:true_block) { proc { |num| num > HIGHEST_VALUE } }
    let(:false_block) { proc { |num| num <= HIGHEST_VALUE } }
    let(:true_array) { [nil, false, true, []] }
    let(:false_array) { [nil, false, nil, false] }
    it '1. returns true if the block never returns true for all elements' do
      expect(array.my_none?(&true_block)).to eq(array.none?(&true_block))
    end

    it '2. returns false if the block ever returns true for all elements' do
      expect(array.my_none?(&false_block)).to eq(array.none?(&false_block))
    end

    it '3. does not mutate the original array' do
      array.my_none? { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

    context 'A. when no block or argument is given' do
      it '1. returns true only if none of the collection members is true' do
        expect(false_array.my_none?).to be true
      end

      it '2. returns false only if one of the collection members is true' do
        expect(true_array.my_none?).to be false
      end
    end

    context 'B. when a pattern other than Regex or a Class is given' do
      it '1. returns true only if none of the collection matches the pattern' do
        expect(words.my_none?(5)).to be words.none?(5)
      end
      it '2. returns false only if one of the collection matches the pattern' do
        words[0] = 5
        expect(words.my_none?(5)).to be words.none?(5)
      end
    end
  end

  describe 'RSPEC# - Method: #my_count' do
    let(:block) { proc { |x| x > 2 } }
    it '1. I/P-Array: returns the number of items' do
      expect(array.my_count).to eq array.count
    end

    it '2. I/P-Range: returns the number of items' do
      expect(range.my_count).to eq range.count
    end

    it '3. counts the number of elements yielding a true value if a block is given' do
      expect(array.my_count(&block)).to eq array.count(&block)
    end

    it '4. does not mutate the original array' do
      array.my_count { |num| num + 1 }
      expect(array).to eq(array_clone)
    end
  end

  describe 'RSPEC# - Method: #my_map' do
    let(:block) { proc { |x| x + 2 } }

    it '1. returns Enumerator after applying the block given to each element of enum' do
      expect(array.my_map(&block)).to eq array.map(&block)
    end

    it '2. returns Enumerator after applying the inline block given to each element of enum' do
      expect(array.my_map { |num| num < 10 }).to eq(array.map { |num| num < 10 })
    end

    it '3. I/P-Array: returns a new array with the results of running a given block' do
      expect(array.my_map(&block)).to eq array.map(&block)
    end

    it '4. I/P-Array: returns a new array with the results of running a given block' do
      expect(range.my_map(&block)).to eq range.map(&block)
    end

    it 'returns an Enumerator if no block is given' do
      expect(array.my_map).to be_an(Enumerator)
    end

    it ' does not mutate the original array' do
      array.my_map { |num| num + 1 }
      expect(array).to eq(array_clone)
    end
  end

  describe 'RSPEC# - Method: #my_inject' do
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

# rubocop:enable Metrics/BlockLength
