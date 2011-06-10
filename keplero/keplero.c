/* Nome del file sorgente: keplero.c
 * Scopo: programma per la risoluzione numerica
 * dell'equazione di Keplero con il metodo di Newton-Raphson
 * e con quello delle funzioni di Bessel.
 * Dati di input: semiasse maggiore, eccentricità e periodo
 * delle orbite, velocità angolare media.
 * Output: due file con i risultati ottenuti con i due metodi
 * differenti. I file sono così organizzati: sono suddiviso in
 * dieci colonne, nella prima c'è il tempo t, nelle nove
 * successive ci sono i valori delle anomalie eccentriche,
 * distanze dal fuoco e anomalie vere al tempo t per i tre
 * differenti valori dell'eccentricità. Il file può essere letto
 * da un programma per la realizzazione di grafici.
 * Autore: Mosè Giordano
 * Data: 11/06/2011
 */

#include <stdio.h>
#include <math.h>
#include <gsl/gsl_sf_bessel.h>

/* Specifico il valore della precisione desiderata */
#define PRECISIONE 1e-12
/* Definisco una macro con il valore del numero pi */
#define PI 3.141592653589793
/* Numero di punti in cui trovare l'anomalia eccentrica */
#define PUNTI 1000
/* Dimensione del vettore `e' */
#define N 3
/* Numero di iterazioni da compiere con il metodo di Bessel
 * prima di fermarsi */
#define MAX_BESSEL 200

/* Funzione di cui vogliamo trovare le radici. Il primo
 * argomento è l'anomalia eccentrica, il secondo argomento
 * è l'eccentricità, il terzo è l'anomalia media, cioè il
 * prodotto della velocità angolare media e del tempo.
 */
double f(double psi, double e, double phi)
{
  return psi-e*sin(psi)-phi;
}

/* Funzione che restituisce la derivata rispetto a x della
 * funzione di Bessel J_n(x) sfruttando le proprietà delle
 * funzioni di Bessel. Il primo argomento è l'ordine della
 * funzione di Bessel, il secondo è il suo argomento
 */
double diff_besselj(int n, double x)
{
  return (gsl_sf_bessel_Jn(n-1,x)-gsl_sf_bessel_Jn(n+1,x))/2.;
}

/* Funzione che restituisce il valore dell'anomalia eccentrica
 * psi in corrispondenza dell'anomalia media phi calcolata
 * usando il metodo di Newton. Il primo argomento è l'anomalia
 * media, il secondo è l'eccentricità
 */
double psi_newton(double phi, double e)
{
  double psi=phi; /* anomalia eccentrica. Punto iniziale = phi */
  /* Se il valore della funzione valutata nel punto iniziale
   * è maggiore della precisione desiderata utilizzo il metodo
   * di Newton per cercare un nuovo punto.
   */
  while(fabs(f(psi,e,phi))>PRECISIONE)
    psi-=(psi-e*sin(psi)-phi)/(1-e*cos(psi));
  return psi;
}

/* Funzione che restituisce il valore dell'anomalia eccentrica
 * psi in corrispondenza dell'anomalia media phi calcolata
 * usando il metodo delle funzioni di Bessel. Il primo argomento
 * è l'anomalia media, il secondo l'eccentricità
 */
double psi_bessel(double phi, double e)
{
  int n;
  double psi=phi;
  for(n=1;n<=MAX_BESSEL;n++)
    psi+=2*gsl_sf_bessel_Jn(n,n*e)*sin(n*phi)/n;
  return psi;
}

/* Funzione che restituisce il valore della distanza r da
 * fuoco al tempo t, calcolata con il metodo delle funzioni
 * di Bessel. Il primo argomento è l'anomalia media, il
 * secondo il semiasse maggiore, il terzo l'eccentricità
 */
double r_bessel(double phi, double semiasse, double e)
{
  int n;
  double distanza=semiasse*(1+pow(e,2)/2.);
  for(n=1;n<=MAX_BESSEL;n++)
    distanza-=2*semiasse*e*diff_besselj(n,n*e)*cos(n*phi)/n;
  return distanza;
}

/* Funzione che restituisce il valore della distanza dal
 * fuoco. Il primo argomento è la lunghezza del semiasse
 * maggiore, il secondo è l'eccentricità dell'orbita, il
 * terzo è il valore dell'anomalia eccentrica.
 */
double r(double semiasse, double e, double psi)
{
  return semiasse*(1-e*cos(psi));
}

/* Funzione che restituisce il valore dell'anomalia vera. Il
 * primo argomento è l'eccentricità, il secondo è
 * l'anomalia eccentrica.
 */
double anomvera(double e, double psi)
{
  if(psi<=PI)
    return 2*atan(sqrt((1+e)/(1-e))*tan(psi/2));
  else
    return 2*(atan(sqrt((1+e)/(1-e))*tan(psi/2))+PI);
}

int main(){
  /* Definizione delle variabili */
  double a; /* semiasse maggiore dell'orbita */
  double e[N]={0,0.5,0.8}; /* eccentricità delle orbite */
  double periodo;   /* periodo dell'orbita */
  double t; /* tempo in cui calcolare l'anomalia eccentrica */
  double tmin, tmax; /* istanti di tempo minimo e massimo in
		      * cui calcolare l'anomalia eccentrica */
  double omega; /* velocità angolare media */
  double psi; /* anomalia eccentrica */
  int i; /* contatore da usare nel ciclo for */
  FILE *newton, *bessel; /* puntatori a file */

  /* Inizializzazione delle variabili */
  a=2.5; /* 2.5·10^6 Km */
  periodo=10; /* 10 ore */
  tmin=0; /* Abbiamo supposto che al periapside t=0 */
  tmax=periodo;
  omega=2*PI/periodo;

  /* Apro i file su cui scrivere i risultati */
  newton=fopen("newton.dat","w");
  bessel=fopen("bessel.dat","w");
  /* Cerco il valore dell'anomalia eccentrica nei PUNTI punti
   * dell'intervallo [tmin,tmax]
   */
  for(t=tmin;t<=tmax;t+=(tmax-tmin)/PUNTI)
    {
      fprintf(newton,"%f",t);
      fprintf(bessel,"%f",t);
      /* Ripeto calcoli per tutti i valori dell'eccentricità */
      for(i=0;i<N;i++)
	{
	  /* Scrivo su file i risultati del metodo di Newton*/
	  psi=psi_newton(omega*t,e[i]);
	  fprintf(newton,"\t%f\t%f\t%f",psi,
		  r(a,e[i],psi),
		  anomvera(e[i],psi));
	  /* Scrivo su file i risultati del metodo delle
	   * funzioni di Bessel */
	  psi=psi_bessel(omega*t,e[i]);
	  fprintf(bessel,"\t%f\t%f\t%f",psi,
		  r_bessel(omega*t,a,e[i]),
		  anomvera(e[i],psi));
	}
      fprintf(newton,"\n");
      fprintf(bessel,"\n");
    }
  /* Chiudo i file */
  fclose(newton);
  fclose(bessel);
  return 0;
}
