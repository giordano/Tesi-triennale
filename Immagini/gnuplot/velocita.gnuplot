# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output
set output 'Immagini/gnuplot/velocita.tex'
set key top center
unset xtics
set ytics nomirror
set format y "$%g$"
set xtics ("{\\scriptsize periapside: $\\theta=0$}" 0, \
    "{\\scriptsize apoapside: $\\theta=\\pi$}" pi, \
    "{\\scriptsize periapside: $\\theta=2\\pi$}" 2*pi) nomirror
set border 3 # visualizza solo i bordi in basso e a sinistra
set size 0.9,0.9
set xlabel "$\\theta$"  # etichetta per l'asse x
set ylabel "$v^2(\\theta)/GM_\\textup{T}$" # etichetta per l'asse y
r(a,e,x)=a*(1-e**2)/(1+e*cos(x))
v(a,e,x)=2./r(a,e,x)-1/a
a=1
e1=0
e2=0.5
e3=0.8
plot [0:2*pi][0:(1+e3)/(a*(1-e3))] v(a,e1,x) lw 2 title "$e=0$",\
     v(a,e2,x) lw 2 title "$e=0.5$",\
     v(a,e3,x) lw 2 title "$e=0.8$"
