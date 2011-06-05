# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output
set output 'Immagini/gnuplot/velocita_los_due_corpi.tex'
unset xtics
#set ytics nomirror
set format y "$%g$"
set key bottom right
set xtics ("{\\scriptsize periapside: $\\chi=0$}" 0, \
    "{\\scriptsize apoapside: $\\chi=\\pi$}" pi, \
    "{\\scriptsize periapside: $\\chi=2\\pi$}" 2*pi)
set xlabel "$\\chi$"  # etichetta per l'asse x
set ylabel "$v_\\textup{los}(\\chi)$ (\\si{\\kilo\\metre\\per\\second})"
r(a,e,x)=a*(1-e**2)/(1+e*cos(x))
GM=5e11
v(a,e,x)=sqrt(GM*(2./r(a,e,x)-1/a))
# se e=0 l'angolo alpha vale sempre pi/2, quindi definisco la funzione per casi
alpha(x,e)=e==0 ? pi/2 : \
                ((x<=pi) ? atan(1/tan(x)+1/(e*sin(x))) :\
                atan(1/tan(x)+1/(e*sin(x)))-pi)
beta(x,e)=e==0 ? x+pi/2 : x+alpha(x,e)
vlos(a,e,x)=v(a,e,x)*(cos(beta(x,e)))
a=5e7
e=0.5
m1=5.
m2=1.
mu=m1*m2/(m1+m2)
plot [0:2*pi] -mu/m1*vlos(a,e,x)-40 lw 2 title "$m_1$",\
     mu/m2*vlos(a,e,x)-40 lw 2 title "$m_2$"
