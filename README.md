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
gnuplot FEL.pe



