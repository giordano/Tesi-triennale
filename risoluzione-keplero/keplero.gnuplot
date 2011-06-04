# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output.
set output 'risoluzione-keplero/keplero1.tex'
plot 'risoluzione-keplero/keplero.dat' u 1:2, 'risoluzione-keplero/keplero.dat' u 1:5, 'risoluzione-keplero/keplero.dat' u 1:8
set output 'risoluzione-keplero/keplero2.tex'
plot 'risoluzione-keplero/keplero.dat' u 1:3, 'risoluzione-keplero/keplero.dat' u 1:6, 'risoluzione-keplero/keplero.dat' u 1:9
set output 'risoluzione-keplero/keplero3.tex'
plot 'risoluzione-keplero/keplero.dat' u 1:4, 'risoluzione-keplero/keplero.dat' u 1:7, 'risoluzione-keplero/keplero.dat' u 1:10
