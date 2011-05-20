# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output.
set output 'Immagini/gnuplot/ellisse_vlos.tex'
unset key
# unset border
# unset xtics
# unset ytics
set size ratio -1
set polar	# per poter inserire l'equazione polare dell'ellisse...
set trange [0:2*pi] 	# ...con la variabile t che va da 0 a 2*pi
set samples 1000 # imposta il numero di punti a 1000
a=2.
e=0.7
b=a*sqrt(1.-e**2)
c=a*e
p=a*(1.-e**2)
Q1=1./4.*pi
Q2=1.38*pi
r(t)=p/(1.+e*cos(t))
alpha(t)=(atan(1/tan(t) + 1/(e*sin(t))))
beta(t)=(t<=pi) ? t+alpha(t) : (t+alpha(t)-pi)
v(t)=2./r(t)-1./a
vx(t)=v(t)*cos(beta(t))
vy(t)=v(t)*sin(beta(t))
vr(t)=e*sin(t)/sqrt(p)
vrx(t)=vr(t)*cos(t)
vry(t)=e*sin(t)*sin(t)
vl(t)=(1.+e*cos(t))/sqrt(p)
vlx(t)=vl(t)*cos(t+pi/2)
vly(t)=vl(t)*sin(t+pi/2)
set xrange [-(a+c):1.6*(a-c)]
set yrange [-1.4*b:1.4*b]
set arrow from 0,-1.2*b to 0,1.2*b filled # asse y
set arrow from -1.05*(a+c),0 to 1.3*a*(1-e),0 filled # asse x
print r(Q1)*cos(Q1),  r(Q1)*cos(Q1)+vx(Q1)
### punto Q1
set arrow from 0,0 to r(Q1)*cos(Q1),r(Q1)*sin(Q1) filled
# vettore velocità
set arrow from r(Q1)*cos(Q1),r(Q1)*sin(Q1) to \
    r(Q1)*cos(Q1)+vx(Q1),r(Q1)*sin(Q1)+vy(Q1) filled
# componente vr
set arrow from r(Q1)*cos(Q1),r(Q1)*sin(Q1) to \
    r(Q1)*cos(Q1)+vrx(Q1),r(Q1)*sin(Q1)+vry(Q1) filled
#componente vl
set arrow from r(Q1)*cos(Q1),r(Q1)*sin(Q1) to \
    r(Q1)*cos(Q1)+vlx(Q1),r(Q1)*sin(Q1)+vly(Q1) filled


### punto Q2
set arrow from 0,0 to r(Q2)*cos(Q2),r(Q2)*sin(Q2) filled
# vettore velocità
set arrow from r(Q2)*cos(Q2),r(Q2)*sin(Q2) to \
    r(Q2)*cos(Q2)+vx(Q2),r(Q2)*sin(Q2)+vy(Q2) filled
# componente vr
set arrow from r(Q2)*cos(Q2),r(Q2)*sin(Q2) to \
    r(Q2)*cos(Q2)+vrx(Q2),r(Q2)*sin(Q2)+vry(Q2) filled
#componente vl
set arrow from r(Q2)*cos(Q2),r(Q2)*sin(Q2) to \
    r(Q2)*cos(Q2)+vlx(Q2),r(Q2)*sin(Q2)+vly(Q2) filled
# set label "{\\scriptsize $r$}" at r(pi/4)*cos(pi/4)/2-0.02,r(pi/4)*sin(pi/4)/2+0.02
# set label "{\\scriptsize $\\theta-\\tilde\\omega$}" at a*(1-e)/3+0.1,0.05
# set label "{\\scriptsize $x$}" at 1.5*(a-c),-0.03
# set label "{\\scriptsize $y$}" at 0.05,1.2*b
plot r(t) lw 2
# set object 1 circle center 1.5*(a-c),0 size (a-c)/2 arc [160:200] # disegna occhio
