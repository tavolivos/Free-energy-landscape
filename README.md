# Free-energy-landscape
In this repository, we present a simple procedure to perform Free Energy landscape plots, taking molecular dynamics results.

Step 1: RMSD and Rg data from MD
gmx rms -s md_0_10.tpr -f outputfile.xtc -o rmsd.xvg -tu ps   #note that time has to be in ps.
gmx gyrate -s md_0_10.tpr -f outputfile.xtc -o rg.xvg

Step 2: perl script creates a thridth columm to obtain data in the order of time, RMSD and Rg.
perl sham.pl -i1 rmsd.xvg -i2 rg.xvg -data1 1 -data2 1 -o graph.xvg

Step 3: Free energy calculation with gmx sham
gmx sham -f graph.xvg -ls gibbs.xpm

Step 4: convert .xpm to .dat file
python2.7 xpm2txt.py -f gibbs.xpm -o FEL.dat

Step 5: Plotting in GNUPLOT
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
