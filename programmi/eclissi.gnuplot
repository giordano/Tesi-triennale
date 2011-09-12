# imposta il terminale su `epslatex'
set term epslatex

set style data lines # stile dei dati: linea
unset key
set format x "$%g$"
set format y "$%g$"

set output 'programmi/distanza_proiettata.tex'
set xlabel "fase" # etichetta asse x
set ylabel "$d/(r_\\star + r)$"
set ytics 1 # imposto manualmente a 1 frequenza dei tic su asse y
plot [0.5:2.5] 'programmi/eclissi.dat' using 1:14 lw 2

set ytics autofreq

set output 'programmi/flusso.tex'
set xlabel "fase" # etichetta asse x
set ylabel "$F$"
plot [0.975:1.015][0.985:1.005] 'programmi/eclissi.dat' using 1:15 lw 2

set format x "$\\num{%g}$" # formato dei tic dell'asse x
set format y "$\\num{%g}$" # formato dei tic dell'asse y
set xtics rotate
set zeroaxis linewidth 2

set output 'programmi/piano_orbitale.tex'
set xlabel "$x$ (\\si{\\centi\\metre})"
set ylabel "$y$ (\\si{\\centi\\metre})"
plot 'programmi/eclissi.dat' using 2:3 lw 2

set output 'programmi/piano_cielo.tex'
set xlabel "$x\\prime\\prime$ (\\si{\\centi\\metre})" offset 0,5
set ylabel "$y\\prime\\prime$ (\\si{\\centi\\metre})" offset 8,0
set bmargin 6
set lmargin 11
set key
plot 'programmi/eclissi.dat' using 9:10 lw 2title "Stella",\
     'programmi/eclissi.dat' using 12:13 lw 2 lt 5 title "Pianeta"
