set terminal wxt size 800,600
data_file = "D:/ruby/sort_profiler/data/bubble_sort_data.txt"

set grid
set key below center
set xlabel "Количество элементов массива"
set ylabel "Время сортировки, мс"
set xrange [*:70000]

f(x) = a*x**n
fit f(x) data_file via a, n

plot \
data_file with points pointtype 7 pointsize 0.7 linecolor "black" title "bubble_sort", \
f(x) with lines linewidth 2.0 linecolor "blue" title sprintf("O(n) = %2.2g n^{%2.2g}", a, n)
