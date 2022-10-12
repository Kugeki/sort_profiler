set terminal wxt size 800,600

set grid
set key below center
set xlabel "Количество элементов массива"
set ylabel "Время сортировки, мс"
set xrange [*:70000]


data_file_selection_sort = "D:/ruby/sort_profiler/data/selection_sort_data.txt"
f_selection_sort(x) = a_selection_sort*x**n_selection_sort
fit f_selection_sort(x) data_file_selection_sort via a_selection_sort, n_selection_sort

data_file_bubble_sort = "D:/ruby/sort_profiler/data/bubble_sort_data.txt"
f_bubble_sort(x) = a_bubble_sort*x**n_bubble_sort
fit f_bubble_sort(x) data_file_bubble_sort via a_bubble_sort, n_bubble_sort


plot \
data_file_selection_sort with points pointtype 7 pointsize 0.7 linecolor "black" title "SelectionSort", \
f_selection_sort(x) with lines linewidth 2.0 linecolor rgb "#ab332d" title sprintf("O(n) = %2.2g n^{%2.2g}", a_selection_sort, n_selection_sort), \
data_file_bubble_sort with points pointtype 7 pointsize 0.7 linecolor "black" title "BubbleSort", \
f_bubble_sort(x) with lines linewidth 2.0 linecolor rgb "#11d227" title sprintf("O(n) = %2.2g n^{%2.2g}", a_bubble_sort, n_bubble_sort), \
