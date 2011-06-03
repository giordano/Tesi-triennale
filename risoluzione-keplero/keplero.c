/* Nome del file sorgente: keplero.c
 * Scopo: programma per la risoluzione numerica dell'equazione di Keplero con il
 * metodo di Newton-Raphson.
 * Dati di input: eccentricità e periodi delle orbite, velocità angolare media.
 * Output: un file così organizzato: è suddiviso in sette colonne, nella prima
 * c'è il tempo, nelle sei successive ci sono i valori delle anomalie
 * eccentriche e vere al tempo t per i tre differenti valori
 * dell'eccentricità. In questo modo può essere letto da un programma per la
 * realizzazione di grafici.
 * Autore: Mosè Giordano
 * Data: 03/06/2011
 */

#include <stdio.h>
#include <math.h>

/* Specifico il valore della precisione desiderata */
#define PRECISIONE 1e-12
/* Definisco una macro con il valore del numero pi */
#define PI 3.141592653589793
/* Numero di punti in cui vogliamo trovare il valore dell'anomalie eccentrica */
#define PUNTI 1000

/* Funzione di cui vogliamo trovare le radici. Il primo argomento è l'anomalia
 * eccentrica, il secondo argomento è l'eccentricità, il terzo è l'anomalia
 * media, cioè il prodotto della velocità angolare media e del tempo.
 */
double f(double x,double a,double b)
{
  return x-a*sin(x)-b;
}

/* Funzione che restituisce il valore dell'anomalia vera. Il primo argomento è
 * l'eccentricità, il secondo è l'anomalia eccentrica.
 */
double anomvera(double a, double b)
{
  if(b<=PI)
    return 2*atan(sqrt((1+a)/(1-a))*tan(b/2));
  else
    return 2*(atan(sqrt((1+a)/(1-a))*tan(b/2))+PI);
}

int main(){
  /* Definizione delle variabili */
  double e[3]={0,0.5,0.8}; /* eccentricità delle orbite */
  double periodo;   /* periodo dell'orbita */
  double t; /* istante di tempo in cui calcolare l'anomalia eccentrica */
  double tmin, tmax; /* istanti di tempo minimo e massimo in cui calcolare
		      * l'anomalia eccentrica */
  double omega; /* velocità angolare media */
  double psi; /* anomalia eccentrica */
  int i; /* contatore da usare nel ciclo for */
  FILE *pf; /* puntatore a file */

  /* Inizializzazione delle variabili */
  periodo=10; /* 10 ore */
  tmin=0;
  tmax=periodo;
  omega=2*PI/periodo;

  /* Apro il file su cui scrivere i risultati */
  pf=fopen("keplero.dat","w");
  /* Cerco il valore dell'anomalia eccentrica nei PUNTI punti dell'intervallo
   * [tmin,tmax]
   */
  for(t=tmin;t<=tmax;t+=(tmax-tmin)/PUNTI)
    {
      /* Pongo come punto iniziale del metodo di Newton
       *     anomalia eccentrica = anomalia media
       */
      psi=omega*t;
      fprintf(pf,"%f",omega*t);
      /* Ripeto i calcoli per tutti e tre i valori dell'eccentricità */
      for(i=0;i<3;i++)
	{
	  /* Se il valore della funzione valutata nel punto iniziale è maggiore
	   * della precisione desiderata utilizzo il metodo di Newton per
	   * trovare un nuovo punto.
	   */
	  while(fabs(f(psi,e[i],omega*t))>PRECISIONE)
	    psi-=(psi-e[i]*sin(psi)-omega*t)/(1-e[i]*cos(psi));
	  /* Scrivo su file i risultati */
	  fprintf(pf,"\t%f\t%f",psi,anomvera(e[i],psi));
	}
      fprintf(pf,"\n");
    }
  /* Chiudo il file */
  fclose(pf);
  return 0;
}
