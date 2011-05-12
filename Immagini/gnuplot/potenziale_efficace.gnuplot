# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output
set output 'Immagini/gnuplot/potenziale_efficace.tex'
unset key
unset border
unset xtics
unset ytics
set size 0.8,0.8
set xrange [-0.2:8]
set yrange [-30:30]
set arrow from 0,-30 to 0,30 filled # asse y
set arrow from 0,0 to 8,0 filled # asse x
set arrow from 1,0 to 1,-25 nohead lt 0 lw 5
set arrow from 0,-25 to 8,-25 nohead lt 0 lw 5
set arrow from 0.7,0 to 0.7,-20.408 nohead lt 0 lw 5
set arrow from 1.75,0 to 1.75,-20.408 nohead lt 0 lw 5
set arrow from 0,-20.408 to 8,-20.408 nohead lt 0 lw 5
set arrow from 0,15 to 8,15 nohead lt 0 lw 5
set label "{\\scriptsize $r_\\textup{min}$}" at 0.6,1.5
set label "{\\scriptsize $r_0$}" at 1,1.5
set label "{\\scriptsize $r_\\textup{max}$}" at 1.7,1.5
set label "{\\scriptsize $O$}" at -0.3,0
set label "{\\scriptsize $E_0$}" at -0.3,-25
set label "{\\scriptsize $E_1$}" at -0.3,-20.408
set label "{\\scriptsize $E_2$}" at -0.3,15
set label "{\\scriptsize $U_\\textup{eff}$}" at -0.1,31.5
set label "{\\scriptsize $r(\\theta)$}" at 8,1.5
plot 25/x**2-50/x lw 2 # funzione del tipo a/r^2 - b/r
