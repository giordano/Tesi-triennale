/* Nome del file sorgente: keplero.c
 * Scopo: programma per la risoluzione numerica
 * dell'equazione di Keplero con il metodo di Newton-Raphson
 * e con quello dei coefficienti di Bessel.
 * Input (hard coded): semiasse maggiore, eccentricità e periodo
 * delle orbite, tempo del passaggio al periapside.
 * Output: due file di testo con i risultati ottenuti con i due
 * metodi differenti. I file sono così organizzati: sono suddivisi
 * in dieci colonne, nella prima c'è il tempo t, nelle nove
 * successive ci sono i valori delle anomalie eccentriche,
 * distanze dal fuoco e anomalie vere al tempo t per i tre
 * differenti valori dell'eccentricità. I file possono essere
 * letti da un software per la realizzazione di grafici.
 * Autore: Mosè Giordano
 * Data: 18/09/2011
 * Licenza: GNU General Public License v3 o, a scelta, una
 * versione successiva.  Vedi <http://www.gnu.org/licenses/>.
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
  double P;   /* periodo dell'orbita */
  double t; /* istante di tempo tempo */
  double t0; /* istante del passaggio al periapside */
  double tmin, tmax; /* istanti di tempo minimo e massimo in
		      * cui calcolare l'anomalia eccentrica */
  double omega; /* velocità angolare media */
  double psi; /* anomalia eccentrica */
  int i; /* contatore */
  FILE *newton, *bessel; /* puntatori a file */

  /* Inizializzazione delle variabili */
  a=2.5; /* 2.5·10^6 Km */
  P=10; /* 10 ore */
  t0=0; /* al periapside t=0 s */
  tmin=t0;
  tmax=tmin+P;
  omega=2*M_PI/P;

  /* Apro i file su cui scrivere i risultati */
  newton=fopen("newton.dat","w");
  bessel=fopen("bessel.dat","w");
  /* Cerco il valore dell'anomalia eccentrica nei PUNTI istanti
   * dell'intervallo di tempo [tmin,tmax] */
  for(t=tmin;t<=tmax;t+=(tmax-tmin)/PUNTI)
    {
      fprintf(newton,"%f",t);
      fprintf(bessel,"%f",t);
      /* Ripeto calcoli per tutti i valori dell'eccentricità */
      for(i=0;i<N;i++)
	{
	  /* Calcolo l'anomalia eccentrica con il metodo di
	   * Newton e scrivo su file i risultati */
	  psi=psi_newton(omega*(t-t0),e[i]);
	  fprintf(newton,"\t%f\t%f\t%f",psi,
		  r(a,e[i],psi),
		  anomvera(e[i],psi));
	  /* Calcolo l'anomalia eccentrica con il metodo di
	   * Bessel e scrivo su file i risultati */
	  psi=psi_bessel(omega*(t-t0),e[i]);
	  fprintf(bessel,"\t%f\t%f\t%f",psi,
		  r_bessel(omega*(t-t0),a,e[i]),
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
