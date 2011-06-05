# imposta il terminale su `epslatex'
set term epslatex color
set xlabel "$t$ (\\si{\\hour})"
set format x "$%g$"
set format y "$%g$"
# imposta il primo file di output
set output 'risoluzione-keplero/keplero-anomalia_eccentrica.tex'
set key top left
set ylabel "$\\psi$"
plot 'risoluzione-keplero/keplero.dat' u 1:2 title "$e=0$",\
     'risoluzione-keplero/keplero.dat' u 1:5 title "$e=0.5$",\
     'risoluzione-keplero/keplero.dat' u 1:8 title "$e=0.8$"
# imposta il secondo file di output
set output 'risoluzione-keplero/keplero-raggio.tex'
set key bottom center
set ylabel "$r$ (\\si{\\kilo\\metre})"
plot 'risoluzione-keplero/keplero.dat' u 1:3 title "$e=0$",\
     'risoluzione-keplero/keplero.dat' u 1:6 title "$e=0.5$",\
     'risoluzione-keplero/keplero.dat' u 1:9 title "$e=0.8$"
# imposta il terzo file di output
set output 'risoluzione-keplero/keplero-anomalia_vera.tex'
set key top left
set ylabel "$\\chi$"
plot 'risoluzione-keplero/keplero.dat' u 1:4 title "$e=0$",\
     'risoluzione-keplero/keplero.dat' u 1:7 title "$e=0.5$",\
     'risoluzione-keplero/keplero.dat' u 1:10 title "$e=0.8$"
