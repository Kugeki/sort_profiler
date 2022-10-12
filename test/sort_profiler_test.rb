# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest-power_assert'
require_relative '../lib/sort_profiler'

describe 'Sort profiler tests' do
  before do
    @from = 100
    @to = 300
    @step = 50
    @sort_profiler = SortProfiler.new(from: @from, to: @to, step: @step)
  end

  it 'should not to be empty' do
    refute @sort_profiler.results.empty?
  end

  it 'should profile all SortFunctions' do
    assert @sort_profiler.results.size == SortFunctions.names.size
  end

  it 'should have ((to - from) / step) + 1 entrances in results for every sort' do
    SortFunctions.names.each do |sort_name|
      assert (@sort_profiler.results[sort_name].size == ((@to - @from) / @step + 1)), sort_name
    end
  end

  it 'should not run profile' do
    sp_without_profile = SortProfiler.new(run_profile: false)
    assert sp_without_profile.results.empty?
  end
end
