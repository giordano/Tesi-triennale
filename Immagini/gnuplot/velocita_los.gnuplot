# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output
set output 'Immagini/gnuplot/velocita_los.tex'
unset xtics
unset ytics
set xtics ("{\\scriptsize {periapside: $\\theta=0$}}" 0, \
    "{\\scriptsize apoapside: $\\theta=\\pi$}" pi, \
    "{\\scriptsize{periapside:$\\theta=2\\pi$}}" 2*pi) nomirror
set border 3 # visualizza solo i bordi in basso e a sinistra
set size 0.9,0.9
set xlabel "$\\theta$"  # etichetta per l'asse x
set ylabel "$v_\\textup{los}^2(\\theta)$" # etichetta per l'asse y
set ytics ("$0$" 0) nomirror
r(a,e,x)=a*(1-e**2)/(1+e*cos(x))
v(a,e,x)=2./r(a,e,x)-1/a
vlos(a,e,x)=v(a,e,x)*sin(x) # controllare che la funzione sia giusta, ma credo di sì
a=1
e1=0
e2=0.5
e3=0.8
plot [0:2*pi][-(1+e3)/(a*(1-e3)):(1+e3)/(a*(1-e3))] \
     vlos(a,e1,x) lw 2 title "$e=0$",\
     vlos(a,e2,x) lw 2 title "$e=0.5$",\
     vlos(a,e3,x) lw 2 title "$e=0.8$"
