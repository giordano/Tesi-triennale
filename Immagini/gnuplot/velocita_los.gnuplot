# imposta il terminale su `epslatex'
set term epslatex size 6,3
# imposta il file di output
set output 'Immagini/gnuplot/velocita_los.tex'
set lmargin at screen 0.12
set rmargin at screen 0.86
unset xtics
set format y "$%g$"
set key bottom right
set xtics ("{\\scriptsize periapside: $\\theta=\\theta_0$}" 0, \
    "{\\scriptsize apoapside: $\\theta=\\theta_0+\\pi$}" pi, \
    "{\\scriptsize periapside: $\\theta=\\theta_0+2\\pi$}" 2*pi)
set xlabel "$\\theta$"  # etichetta per l'asse x
set ylabel "$v_\\textup{los}(\\theta)/\\sqrt{GM_\\textup{T}}$" # etichetta per l'asse y
r(a,e,x)=a*(1-e**2)/(1+e*cos(x))
v(a,e,x)=sqrt(2./r(a,e,x)-1/a)
# se e=0 l'angolo alpha vale sempre pi/2, quindi definisco la funzione per casi
alpha(x,e)=e==0 ? pi/2 : \
                ((x<=pi) ? atan(1/tan(x)+1/(e*sin(x))) :\
                atan(1/tan(x)+1/(e*sin(x)))-pi)
beta(x,e)=e==0 ? x+pi/2 : x+alpha(x,e)
vlos(a,e,x)=v(a,e,x)*(cos(beta(x,e)))
a=1
e1=0
e2=0.5
e3=0.8
plot [0:2*pi] vlos(a,e1,x) lw 2 title "$e=0$",\
     vlos(a,e2,x) lw 2 title "$e=0.5$",\
     vlos(a,e3,x) lw 2 title "$e=0.8$"
