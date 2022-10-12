# frozen_string_literal: true

require 'benchmark'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute_accessors'
require 'erb'
require_relative 'sort_functions'

# GraphStyle, describe_sort, etc.

# random array
class Array
  def self.random(size, from = 1, to = 10_000_000)
    Array.new(size) { rand(from..to) }
  end
end

# SortProfiler
class SortProfiler
  attr_accessor :from, :to, :step, :results

  def initialize(from: 1000, to: 10_000, step: 500, run_profile: true)
    @from = from
    @to = to
    @step = step
    @results = {}
    @files_created = false
    profile if run_profile
  end

  def profile(names = SortFunctions.names)
    names.each do |sort_name|
      profile_sort(sort_name)
    end
  end

  def profile_sort(sort_name)
    puts sort_name
    results[sort_name] ||= {}
    (from..to).step(step).each do |n|
      time = Benchmark.measure do
        SortFunctions.call_sort sort_name, Array.random(n)
      end
      results[sort_name][n] = time.real * 1000
    end
  end

  def create_files_with_results
    results.each do |sort_name, profile_stats|
      file = File.open("./data/#{sort_name}_data.txt", 'w')
      profile_stats.each { |n, time| file.write "#{n} #{time}\n" }
    end
    @files_created = true
  end

  def create_graph_script
    create_files_with_results unless @files_created
    sort_functions = SortFunctions.names # required in template
    template_file = 'templates/single_plot.erb'
    render = ERB.new(File.read(template_file))
    File.open('graphs/single_graph.plt', 'w') do |f|
      f.write render.result(binding)
    end
  end

  def create_graph_scripts
    create_files_with_results unless @files_created
    results.each_key do |sort_name|
      template_file = 'templates/plot.erb'
      render = ERB.new(File.read(template_file))
      File.open("graphs/#{sort_name}_graph.plt", 'w') do |f|
        f.write render.result(binding)
      end
    end
  end
end
