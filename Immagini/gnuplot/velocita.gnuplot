# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output
set output 'Immagini/gnuplot/velocita.tex'
set key top center
unset xtics
unset ytics
set xtics ("{\\scriptsize periapside: $\\theta=0$}" 0, \
    "{\\scriptsize apoapside: $\\theta=\\pi$}" pi, \
    "{\\scriptsize{periapside:$\\theta=2\\pi$}}" 2*pi) nomirror
set border 3 # visualizza solo i bordi in basso e a sinistra
set size 0.7,0.7
set xlabel "$\\theta$"  # etichetta per l'asse x
set ylabel "$v^2(\\theta)$" # etichetta per l'asse y
#a=1
#e=0.5
r(a,e,x)=a*(1-e**2)/(1+e*cos(x))
v2(a,e,x)=2./r(a,e,x)-1/a
plot [0:2*pi][0:(1+0.8)/(1*(1-0.8))] v2(1,0,x) lw 2 title "$e=0$",\
     v2(1,0.5,x) lw 2 title "$e=0.5$",\
     v2(1,0.8,x) lw 2 title "$e=0.8$"
