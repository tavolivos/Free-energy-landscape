# Free-energy-landscape<br/>
In this repository, we present a simple procedure to perform Free Energy landscape plots, taking results from molecular dynamics simulation.<br/>

Step 1: RMSD and Rg data from MD<br/>
```sh
gmx rms -s md_0_10.tpr -f outputfile.xtc -o rmsd.xvg -tu ps   #note that time has to be in ps.
gmx gyrate -s md_0_10.tpr -f outputfile.xtc -o rg.xvg
```
Step 2: perl script creates a thrid columm to obtain data in the order of time, RMSD and Rg.<br/>
```sh
perl sham.pl -i1 rmsd.xvg -i2 rg.xvg -data1 1 -data2 1 -o graph.xvg
```
Step 3: Free energy calculation with gmx sham<br/>
```sh
gmx sham -f graph.xvg -ls gibbs.xpm
```
Step 4: convert .xpm to .dat file
```sh
python2.7 xpm2txt.py -f gibbs.xpm -o FEL.dat
```
Step 5: Plotting in GNUPLOT
```sh
gnuplot FEL.p
```
![alt text](https://github.com/tavolivos/Free-energy-landscape/blob/main/FEL.png?raw=true)

