# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output
set output 'Immagini/gnuplot/velocita.tex'
unset key
unset xtics
unset ytics
a=1
e=0.5
set xtics ("{\\scriptsize periapside: $\\theta=0$}" 0, \
    "{\\scriptsize apoapside: $\\theta=\\pi$}" pi, \
    "{\\scriptsize{periapside:$\\theta=2\\pi$}}" 2*pi) nomirror
set border 3 # visualizza solo i bordi in basso e a sinistra
set size 0.8,0.8
set xlabel "$\\theta$"  # etichetta per l'asse x
set ylabel "$v^2(\\theta)$" # etichetta per l'asse y
r(x)=a*(1-e**2)/(1+e*cos(x))
plot [0:2*pi][0:(1+e)/(a*(1-e))] 2./r(x)-1/a lw 2
