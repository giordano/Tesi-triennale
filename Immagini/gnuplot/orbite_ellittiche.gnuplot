# imposta il terminale su `epslatex'
set term epslatex size 5,2.5
# imposta il file di output.
set output 'Immagini/gnuplot/orbite_ellittiche.tex'
set multiplot layout 1,2 # crea due aree di grafico affiancate
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
m1=5.
m2=1.
mu=m1*m2/(m1+m2)
r(t)=p/(1+e*cos(t))
r1(t)=-mu/m1*r(t)
r2(t)=mu/m2*r(t)
set key at -0.6*(a+c),1.2*b
set xrange [-(a+c):2.1*(a-c)]
set yrange [-b:b]
set arrow from -1.05*(a+c),0 to 2.1*(a-c),0 filled # asse x
set label "{\\scriptsize $x$}" at 2.1*(a-c),-0.05
set arrow from 0,-1.2*b to 0,1.2*b filled # asse y
set label "{\\scriptsize $y$}" at 0.05,1.2*b
# primo plot
plot r1(t) lw 2 title "$m_1$", r2(t) lw 2 title "$m_2$"
# secondo plot
set label "{\\scriptsize $m_1$}" at -0.08,-0.05
plot r(t) lw 2 title "$\\mu$"
unset multiplot
