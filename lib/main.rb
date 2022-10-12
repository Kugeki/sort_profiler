# frozen_string_literal: true

require_relative 'sort_profiler'

sort_profiler = SortProfiler.new
sort_profiler.create_graph_script
sort_profiler.create_graph_scripts

# TODO: ProfileResult class. Methods: to_h, create_graph_script, create_graph_scripts,
# create_data_files, create_data_file.
