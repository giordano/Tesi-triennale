/* Nome del file sorgente: keplero.c
 * Scopo: programma per la risoluzione numerica
 * dell'equazione di Keplero con il metodo di Newton-Raphson
 * e con quello dei coefficienti di Bessel.
 * Dati di input: semiasse maggiore, eccentricità e periodo
 * delle orbite.
 * Output: due file con i risultati ottenuti con i due metodi
 * differenti. I file sono così organizzati: sono suddiviso in
 * dieci colonne, nella prima c'è il tempo t, nelle nove
 * successive ci sono i valori delle anomalie eccentriche,
 * distanze dal fuoco e anomalie vere al tempo t per i tre
 * differenti valori dell'eccentricità. I file possono essere
 * letti da un programma per la realizzazione di grafici.
 * Autore: Mosè Giordano
 * Data: 17/06/2011
 */

#include <stdio.h>
#include "libreria.h"

/* Numero di punti in cui trovare l'anomalia eccentrica */
#define PUNTI 1000
/* Dimensione del vettore `e' */
#define N 3

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
	  /* Calcolo l'anomalia eccentrica con il metodo di
	   * Newton e scrivo su file i risultati */
	  psi=psi_newton(omega*t,e[i]);
	  fprintf(newton,"\t%f\t%f\t%f",psi,
		  r(a,e[i],psi),
		  anomvera(e[i],psi));
	  /* Calcolo l'anomalia eccentrica con il metodo dei
	   * coefficienti di Bessel e scrivo su file i risultati */
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
