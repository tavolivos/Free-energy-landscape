scale = 1063.0/420.0
set terminal pngcairo  background "#ffffff" enhanced font "Times-New-Roman-Bold,12" fontscale 1.0 size 350*scale, 250*scale fontscale scale linewidth scale pointscale scale
set tmargin at screen 0.75
set bmargin at screen 0.25
set rmargin at screen 0.80
set lmargin at screen 0.20
set key on b c outside horizontal
set output 'FEL.png'
set title "Free Energy Landscape"
set xlabel "RMSD" rotate parallel
set ylabel "Rg" rotate parallel
set zlabel "Gibbs Free Energy" rotate parallel
set grid
unset key
set pm3d implicit at b
set view map scale 1
unset surface
set dgrid3d 50,50
set hidden3d
set contour s
set autoscale xfix; set autoscale yfix
sp 'FEL.dat' u 1:2:3 w l
