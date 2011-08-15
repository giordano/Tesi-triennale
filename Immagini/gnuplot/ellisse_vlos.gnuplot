# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output.
set output 'Immagini/gnuplot/ellisse_vlos.tex'
unset key
unset border
unset xtics
unset ytics
set size ratio -1
set polar	# per poter inserire l'equazione polare dell'ellisse...
set trange [0:2*pi] 	# ...con la variabile t che va da 0 a 2*pi
set samples 1000 # imposta il numero di punti a 1000
set tmargin 0
set rmargin 0
set bmargin 0
set lmargin 0
a=2.
e=0.7
b=a*sqrt(1.-e**2)
c=a*e
p=a*(1.-e**2)
r(t)=p/(1.+e*cos(t))
alpha(t)=(t<=pi) ? (atan(1/tan(t) + 1/(e*sin(t)))) : \
                 (atan(1/tan(t) + 1/(e*sin(t)))) + pi
beta(t)=t+alpha(t)
v(t)=2./r(t)-1./a
vx(t)=v(t)*cos(beta(t))
vy(t)=v(t)*sin(beta(t))
vr(t)=e*sin(t)/sqrt(p)
vrx(t)=vr(t)*cos(t)
vry(t)=e*sin(t)*sin(t)
vl(t)=(1.+e*cos(t))/sqrt(p)
vlx(t)=vl(t)*cos(t+pi/2)
vly(t)=vl(t)*sin(t+pi/2)
set xrange [-1.05*(a+c):2.5*(a-c)]
set yrange [-1.2*b:1.35*b]
set arrow from 0,-1.2*b to 0,1.2*b filled # asse y
set arrow from -1.05*(a+c),0 to 1.3*a*(1-e),0 filled # asse x

### primo punto in cui rappresentare la velocità
Q=0.6*pi
# set arrow from 0,0 to r(Q1)*cos(Q),r(Q)*sin(Q) filled
# vettore velocità
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vx(Q),r(Q)*sin(Q)+vy(Q) filled
set label "{\\scriptsize $\\bm{v}$}" at \
    r(Q)*cos(Q)+vx(Q)-0.05,r(Q)*sin(Q)+vy(Q)+0.05
# componente vr
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vrx(Q),r(Q)*sin(Q)+vry(Q) filled lt 2 lw 2
# componente vl
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vlx(Q),r(Q)*sin(Q)+vly(Q) filled lt 2 lw 2
# velocità lungo la linea di vista
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vx(Q),r(Q)*sin(Q) filled lt 5 lw 2
set label "{\\scriptsize $\\bm{v}_\\textup{los}$}" at \
    r(Q)*cos(Q)+vx(Q)-0.14,r(Q)*sin(Q)

### secondo punto in cui rappresentare la velocità
Q=1.38*pi
# set arrow from 0,0 to r(Q)*cos(Q),r(Q)*sin(Q) filled
# vettore velocità
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vx(Q),r(Q)*sin(Q)+vy(Q) filled
set label "{\\scriptsize $\\bm{v}$}" at \
    r(Q)*cos(Q)+vx(Q)+0.05,r(Q)*sin(Q)+vy(Q)+0.05
# componente vr
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vrx(Q),r(Q)*sin(Q)+vry(Q) filled lt 2 lw 2
# componente vl
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vlx(Q),r(Q)*sin(Q)+vly(Q) filled lt 2 lw 2
# velocità lungo la linea di vista
set arrow from r(Q)*cos(Q),r(Q)*sin(Q) to \
    r(Q)*cos(Q)+vx(Q),r(Q)*sin(Q) filled lt 5 lw 2
set label "{\\scriptsize $\\bm{v}_\\textup{los}$}" at \
    r(Q)*cos(Q)+vx(Q)+0.14,r(Q)*sin(Q)

set label "{\\scriptsize $x$}" at 1.2*(a-c),-0.08
set label "{\\scriptsize $y$}" at -0.08,1.2*b
set label "{\\scriptsize $O\\equiv M_\\textup{T}$}" at -0.28,-0.08
set label "{\\scriptsize osservatore}" at 2.2*(a-c),0.2
set object 1 circle center 2.5*(a-c),0 size (a-c)/2 arc [160:200] # disegna occhio
plot r(t) lw 2
