# imposta il terminale su `epslatex'
set term epslatex color solid
set xlabel "$t$ (\\si{\\hour})" # etichetta asse x
set format x "$%g$"
#imposta lo stile dei dati da graficare come linea e punto
set style data linespoints
# imposta il primo file di output
set output 'risoluzione-keplero/keplero-raggio.tex'
set key bottom center # posizione legenda
set ylabel "$r$ (\\SI{e6}{\\kilo\\metre})" # etichetta asse y
set format y "$%g$"
plot 'risoluzione-keplero/keplero.dat' u 1:3 title "$e=0$",\
     'risoluzione-keplero/keplero.dat' u 1:6 title "$e=0.5$",\
     'risoluzione-keplero/keplero.dat' u 1:9 title "$e=0.8$"
# imposta il secondo file di output
set output 'risoluzione-keplero/keplero-anomalia_eccentrica.tex'
set key top left # posizione legenda
set ylabel "$\\psi$" # etichetta asse y
# tic dell'asse y per i due grafici seguenti
set ytics ("$0$" 0, "$\\pi/4$" pi/4, "$\\pi/2$" pi/2, \
           "$3\\pi/4$" 3*pi/4, "$\\pi$" pi, "$5\\pi/4$" 5*pi/4,\
           "$3\\pi/2$" 3*pi/2, "$7\\pi/4$" 7*pi/4, "$2\\pi$" 2*pi)
plot 'risoluzione-keplero/keplero.dat' u 1:2 title "$e=0$",\
     'risoluzione-keplero/keplero.dat' u 1:5 title "$e=0.5$",\
     'risoluzione-keplero/keplero.dat' u 1:8 title "$e=0.8$"
# imposta il terzo file di output
set output 'risoluzione-keplero/keplero-anomalia_vera.tex'
set key top left # posizione legenda
set ylabel "$\\chi$" # etichetta asse y
plot 'risoluzione-keplero/keplero.dat' u 1:4 title "$e=0$",\
     'risoluzione-keplero/keplero.dat' u 1:7 title "$e=0.5$",\
     'risoluzione-keplero/keplero.dat' u 1:10 title "$e=0.8$"
