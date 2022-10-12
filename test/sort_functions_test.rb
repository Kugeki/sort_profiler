# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest-power_assert'
require_relative '../lib/sort_functions'

describe 'Sorts functions tests' do
  before do
    @array = Array.new(100) { rand(1..10_000) }
    @array = Array.new(100) { rand(1..10_000) } while @array == @array.sort
  end

  it 'should return an array' do
    SortFunctions.names.each do |sort_name|
      assert_instance_of Array, (SortFunctions.call_sort sort_name, @array), sort_name
    end
  end

  it 'should not modify an array' do
    original_array = @array.dup
    SortFunctions.names.each do |sort_name|
      SortFunctions.call_sort sort_name, @array

      assert (@array == original_array), sort_name
    end
  end

  it 'should be sorted' do
    sorted_array = @array.sort
    SortFunctions.names.each do |sort_name|
      expected = (1..11).to_a
      result = SortFunctions.call_sort sort_name, [5, 8, 7, 10, 6, 11, 1, 4, 2, 3, 9]
      assert (expected == result), sort_name

      expected = sorted_array
      result = SortFunctions.call_sort sort_name, @array
      assert (expected == result), sort_name
    end
  end
end
