# imposta il terminale su `epslatex'
set term epslatex
# imposta il file di output.
set output 'Immagini/gnuplot/ellisse.tex'
unset key
unset border
unset xtics
unset ytics
set size 0.8,0.8
set polar	# per poter inserire l'equazione polare dell'ellisse...
set trange [0:2*pi] 	# ...con la variabile t che va da 0 a 2*pi
set samples 1000 # imposta il numero di punti a 1000
a=1
e=0.5
b=a*sqrt(1-e**2)
c=a*e
p=a*(1-e**2)
r(t)=p/(1+e*cos(t))
set xrange [-1.1*(a+c):1.5*a*(1-e)]
set yrange [-1.4*b:1.4*b]
set arrow from 0,-1.2*b to 0,1.2*b filled # asse y
set arrow from -c,-1.2*b to -c,1.2*b filled # asse y'
set arrow from -1.05*(a+c),0 to 1.3*a*(1-e),0 filled # asse x
set arrow from 0,0 to r(pi/4)*cos(pi/4),r(pi/4)*sin(pi/4) filled
set label "{\\scriptsize CDM}" at -0.1,-0.05
set label "{\\scriptsize $c$}" at -c/2,0.05
set label "{\\scriptsize $a$}" at -(c+a/2.),-0.05
set label "{\\scriptsize $b$}" at -(c+0.05),b/2
set label "{\\scriptsize $a(1-e)$}" at a*(1-e)/2.,-0.05
set label "{\\scriptsize $r$}" at r(pi/4)*cos(pi/4)/2-0.04,r(pi/4)*sin(pi/4)/2+0.04
set label "{\\scriptsize $\\theta-\\tilde\\omega$}" at a*(1-e)/3+0.1,0.1
set label "{\\scriptsize $p$}" at -0.05,p/2.
set label "{\\scriptsize $x\\equiv x\\prime$}" at 1.3*a*(1-e),-0.07
set label "{\\scriptsize $y$}" at 0.05,1.2*b
set label "{\\scriptsize $y\\prime$}" at 0.05-c,1.2*b
set object 1 circle center 0,0 size a*(1-e)/3 arc [0:36] # disegna arco di
							 # circonferenza
plot r(t) lw 2
