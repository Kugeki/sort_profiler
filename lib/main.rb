# frozen_string_literal: true

require_relative 'sort_profiler'

sort_profiler = SortProfiler.new
sort_profiler.create_graph_script
sort_profiler.create_graph_scripts

# TODO: SortFunctions class. Methods: get_names, describe_sort, call_sort
