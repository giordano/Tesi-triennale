# imposta il terminale su `epslatex'
set term epslatex

set style data lines # stile dei dati: linea
set format x "$%g$" # formato dei tic dell'asse x
set format y "$%g$" # formato dei tic dell'asse y

set output 'programmi/piano_cielo.tex'
set xlabel "$x\\prime\\prime$ (\\si{\\centi\\metre})"
set ylabel "$y\\prime\\prime$ (\\si{\\centi\\metre})"
set xtics rotate
set zeroaxis
plot 'programmi/eclissi.dat' using 9:10 lw 2title "Stella",\
     'programmi/eclissi.dat' using 12:13 lw 2 lt 5 title "Pianeta"

unset key

set output 'programmi/piano_orbitale.tex'
set xlabel "$x$ (\\si{\\centi\\metre})"
set ylabel "$y$ (\\si{\\centi\\metre})"
plot 'programmi/eclissi.dat' using 2:3 lw 2

unset zeroaxis
set xtics norotate

set output 'programmi/distanza_proiettata.tex'
set xlabel "fase" # etichetta asse x
set ylabel "$d/(r_\\star + r)$"
plot 'programmi/eclissi.dat' using 1:14 lw 2

set output 'programmi/flusso.tex'
set xlabel "fase" # etichetta asse x
set ylabel "$F$"
plot [][0.7:1.1] 'programmi/eclissi.dat' using 1:15 lw 2
