# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest-power_assert'
require_relative '../lib/sort_profiler'

describe 'Sorts functions tests' do
  before do
    @sort_profiler = SortProfiler.new(run_profile: false)
    @array = Array.new(100) { rand(1..10_000) }
    @array = Array.new(100) { rand(1..10_000) } while @array == @array.sort
  end

  it 'should return an array' do
    SortProfiler.class_variable_get('@@sort_functions').each do |sort_name|
      assert_instance_of Array, (@sort_profiler.send sort_name, @array), sort_name
    end
  end

  it 'should not modify an array' do
    original_array = @array.dup
    SortProfiler.class_variable_get('@@sort_functions').each do |sort_name|
      @sort_profiler.send sort_name, @array

      assert (@array == original_array), sort_name
    end
  end

  it 'should be sorted' do
    sorted_array = @array.sort
    SortProfiler.class_variable_get('@@sort_functions').each do |sort_name|
      expected = (1..11).to_a
      result = @sort_profiler.send sort_name, [5, 8, 7, 10, 6, 11, 1, 4, 2, 3, 9]
      assert (expected == result), sort_name

      expected = sorted_array
      result = @sort_profiler.send sort_name, @array
      assert (expected == result), sort_name
    end
  end
end
