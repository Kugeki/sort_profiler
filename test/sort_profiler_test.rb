# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest-power_assert'
require_relative '../lib/sort_profiler'

describe 'Sort profiler tests' do
  before do
    @sort_profiler = SortProfiler.new(run_profile: false)
  end

  it 'should not to be empty' do
    refute SortProfiler.class_variable_get('@@sort_functions').size.zero?
  end
end
