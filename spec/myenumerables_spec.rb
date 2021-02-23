
#spec/myenumerables_spec.rb

require 'rspec'
require_relative '../myenumerables.rb'

ARRAY_SIZE = 10
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'Enumerable module' do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) } }
  let!(:array_clone) { array.clone }

  describe "#my_each"  do

    it 'returns an Enumerator if no block is given' do
      expect(array.my_each).to be_an(Enumerator)
    end

    it 'does not mutate the original array' do
      array.my_each { |num| num + 1 }
      expect(array).to eq(array_clone)
    end    

  end

  describe '#my_each_with_index' do

    it 'returns an enumerator if no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end

    it 'does not mutate the original array' do
      array.my_each_with_index { |num| num + 1 }
      expect(array).to eq(array_clone)
    end

  end

end
