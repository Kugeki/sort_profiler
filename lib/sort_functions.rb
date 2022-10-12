# frozen_string_literal: true

# Sorting functions
class SortProfiler
  describe_sort 'Selection sort' do |array|
    a = array.dup
    (0...a.size).each do |i|
      (i...a.size).each do |j|
        a[i], a[j] = a[j], a[i] if a[i] > a[j]
      end
    end
    a
  end

  describe_sort 'Bubble sort' do |array|
    a = array.dup
    (0...a.size).each do |i|
      (0...(a.size - i - 1)).each do |j|
        a[j], a[j + 1] = a[j + 1], a[j] if a[j] > a[j + 1]
      end
    end
    a
  end
end
