/* Nome: keplero.c
 * Scopo: programma per la risoluzione numerica dell'equazione di Keplero con il
 * metodo di Newton-Raphson.
 * Dati di input: eccentricità e periodi delle orbite, velocità angolare media.
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
 * media.
 */
double f(double x,double a,double b)
{
  return x-a*sin(x)-b;
}

/* Funzione che restituise il valore dell'anomalia vera. Il primo argomento è
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
  double e; /* eccentricità dell'orbita */
  double periodo;   /* periodo dell'orbita */
  double t; /* istante di tempo in cui calcolare l'anomalia eccentrica */
  double tmin, tmax; /* istanti di tempo minimo e massimo in cui calcolare
		      * l'anomalia eccentrica */
  double omega; /* velocità angolare media */
  double psi; /* anomalia eccentrica */
  char nomefile[20];
  int i;
  FILE* pf;

  /* Inizializzazione delle variabili */
  e=0.8;
  periodo=10; /* 10 ore */
  tmin=0;
  tmax=periodo;
  omega=2*PI/periodo;

  /* Apro in lettura il file di output */
  pf=fopen("keplero.dat","w");

  for(t=tmin;t<=tmax;t+=(tmax-tmin)/PUNTI)
    {
      /* Pongo come punto iniziale del metodo di newton
       *     anomalia eccentrica = anomalia media
       */
      psi=omega*t;
      /* Se il valore della funzione valutata nel punto iniziale è maggiore
       * della precisione desiderata utilizzo il metodo di Newton per trovare un
       * nuovo punto.
       */
      while(fabs(f(psi,e,omega*t))>PRECISIONE)
	psi-=(psi-e*sin(psi)-omega*t)/(1-e*cos(psi));
      /* Scrivo su file i risultati */
      fprintf(pf,"%f\t%f\t%f\n",omega*t,psi,anomvera(e,psi));
    }
  /* Chiudo il file */
  fclose(pf);
  return 0;
}
