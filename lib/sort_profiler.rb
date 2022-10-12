# frozen_string_literal: true

require 'benchmark'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/class/attribute_accessors'
require 'erb'

# GraphStyle, describe_sort, etc.
class String
  def to_snake_case
    parameterize(separator: '_')
  end
end

# random array
class Array
  def self.random(size, from = 1, to = 10_000_000)
    Array.new(size) { rand(from..to) }
  end
end

# rubocop:disable Style/ClassVars
# SortProfiler
class SortProfiler
  @@sort_functions = Set.new

  attr_accessor :from, :to, :step, :results

  def self.describe_sort(sort_name, &sort_function)
    sc_name = sort_name.to_snake_case
    @@sort_functions << sc_name

    define_method sc_name do |array|
      sort_function.call array
    end
  end

  def initialize(from: 1000, to: 10_000, step: 500, run_profile: true)
    @from = from
    @to = to
    @step = step
    @results = {}
    @files_created = false
    profile if run_profile
  end

  def profile
    @@sort_functions.each do |sort_name|
      profile_sort(sort_name)
    end
  end

  def profile_sort(sort_name)
    puts sort_name
    results[sort_name] ||= {}
    (from..to).step(step).each do |n|
      time = Benchmark.measure do
        send sort_name, Array.random(n)
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
    sort_functions = @@sort_functions # required in template
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

  require_relative 'sort_functions'
end
# rubocop:enable Style/ClassVars
