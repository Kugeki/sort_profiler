# frozen_string_literal: true

require 'active_support/core_ext/string/inflections' 
# GraphStyle, describe_sort, etc.
class String
  def to_snake_case
    parameterize(separator: '_')
  end
end

# rubocop:disable Style/ClassVars
# TODO: change this class to module according to Ruby Style Guide.
# ...
class SortFunctions
  @@sort_functions = Set.new

  def self.describe_sort(sort_name, &sort_function)
    sc_name = sort_name.to_snake_case
    @@sort_functions << sc_name

    define_singleton_method "#{sc_name}!" do |array|
      sort_function.call array
    end

    define_singleton_method sc_name do |array|
      a = array.dup
      sort_function.call a
      a
    end
  end

  def self.names
    @@sort_functions
  end

  def self.call_sort(name, array)
    send name.to_snake_case, array
  end

  describe_sort 'Selection sort' do |a|
    (0...a.size).each do |i|
      (i...a.size).each do |j|
        a[i], a[j] = a[j], a[i] if a[i] > a[j]
      end
    end
  end

  describe_sort 'Bubble sort' do |a|
    (0...a.size).each do |i|
      (0...(a.size - i - 1)).each do |j|
        a[j], a[j + 1] = a[j + 1], a[j] if a[j] > a[j + 1]
      end
    end
  end
end
# rubocop:enable Style/ClassVars
