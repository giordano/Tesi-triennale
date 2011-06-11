# imposta il terminale su `epslatex'
set term epslatex color solid

# impostazioni per tutti i grafici
set xlabel "$t$ (\\si{\\hour})" # etichetta asse x
set format x "$%g$" # formato dei tic dell'asse x
set style data linespoints # stile dei dati: linea e punto

# impostazioni per i prossimi due grafici
set key bottom center # posizione legenda
set ylabel "$r$ (\\SI{e6}{\\kilo\\metre})" # etichetta asse y
set format y "$%g$" # formato dei tic dell'asse y

# imposta il file di output
set output 'keplero/newton-raggio.tex'
plot 'keplero/newton.dat' using 1:3 title "$e=0$",\
     'keplero/newton.dat' using 1:6 title "$e=0.5$",\
     'keplero/newton.dat' using 1:9 title "$e=0.8$"
# imposta il file di output
set output 'keplero/bessel-raggio.tex'
plot 'keplero/bessel.dat' using 1:3 title "$e=0$",\
     'keplero/bessel.dat' using 1:6 title "$e=0.5$",\
     'keplero/bessel.dat' using 1:9 title "$e=0.8$"

# impostazioni per tutti i grafici successivi
set key top left # posizione legenda
# tic dell'asse y
set ytics ("$0$" 0, "$\\pi/4$" pi/4, "$\\pi/2$" pi/2, \
           "$3\\pi/4$" 3*pi/4, "$\\pi$" pi, "$5\\pi/4$" 5*pi/4,\
           "$3\\pi/2$" 3*pi/2, "$7\\pi/4$" 7*pi/4, "$2\\pi$" 2*pi)

# etichetta asse y per i due grafici successivi
set ylabel "$\\psi$"
# imposta il file di output
set output 'keplero/newton-anomalia_eccentrica.tex'
plot 'keplero/newton.dat' using 1:2 title "$e=0$",\
     'keplero/newton.dat' using 1:5 title "$e=0.5$",\
     'keplero/newton.dat' using 1:8 title "$e=0.8$"
# imposta il file di output
set output 'keplero/bessel-anomalia_eccentrica.tex'
plot 'keplero/bessel.dat' using 1:2 title "$e=0$",\
     'keplero/bessel.dat' using 1:5 title "$e=0.5$",\
     'keplero/bessel.dat' using 1:8 title "$e=0.8$"

# etichetta asse y per i due grafici successivi
set ylabel "$\\chi$"
# imposta il file di output
set output 'keplero/newton-anomalia_vera.tex'
plot 'keplero/newton.dat' using 1:4 title "$e=0$",\
     'keplero/newton.dat' using 1:7 title "$e=0.5$",\
     'keplero/newton.dat' using 1:10 title "$e=0.8$"
# imposta il file di output
set output 'keplero/bessel-anomalia_vera.tex'
plot 'keplero/bessel.dat' using 1:4 title "$e=0$",\
     'keplero/bessel.dat' using 1:7 title "$e=0.5$",\
     'keplero/bessel.dat' using 1:10 title "$e=0.8$"
