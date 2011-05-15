# imposta il terminale su `epslatex'
set term epslatex size 5,2.5
# imposta il file di output.
set output 'Immagini/gnuplot/orbite_ellittiche.tex'
unset border
unset xtics
unset ytics
set size ratio -1
set polar	# per poter inserire l'equazione polare dell'ellisse...
set trange [0:2*pi] 	# ...con la variabile t che va da 0 a 2*pi
set samples 1000 # imposta il numero di punti a 1000
a=1.
e=0.8
b=a*sqrt(1-e**2)
c=a*e
p=a*(1-e**2)
m1=1.
m2=5.
mu=m1*m2/(m1+m2)
r(t)=p/(1+e*cos(t))
r1(t)=-mu/m1*r(t)
r2(t)=mu/m2*r(t)
set xrange [-a*(1+e):a*(1+e)]
set yrange [-a*(1+e)/2:a*(1+e)/2]
set arrow from 0,-1.2*b to 0,1.2*b filled # asse y
#set arrow from -c,-1.2*b to -c,1.2*b filled # asse y'
set arrow from -1.05*(a+c),0 to .95*(a+c),0 filled # asse x
set label "{\\scriptsize $x$}" at 1.*(a+c),0
set label "{\\scriptsize $y$}" at 0.05,1.2*b
#set label "{\\scriptsize $y\\prime$}" at 0.05-c,1.2*b
plot r(t) lw 2 title "$\\mu$", r1(t) lw 2 title "$m_1$", r2(t) lw 2 title "$m_2$"
