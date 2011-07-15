/* Nome del file sorgente: pianeti.c
 * Scopo:
 * Output:
 * Autore: Mosè Giordano
 * Data: 16/07/2011
 */

#include <stdio.h>
#include <gsl/gsl_const_mksa.h> /* header della GSL contenente il valore di
				 * alcune costanti fisiche espresse in MKSA */
#include "libreria.h"

/* Numero di punti in cui trovare l'anomalia eccentrica */
#define PUNTI 1000

int main(){
  /* Definizione delle variabili */
  double a; /* semiasse maggiore dell'orbita */
  double e=0.8; /* eccentricità dell'orbita */
  double periodo; /* periodo dell'orbita */
  double t;
  double tmin, tmax; /* istanti di tempo minimo e massimo in
		      * cui effettuare i calcoli */
  double omega; /* velocità angolare media */
  double psi, theta, r; /* anomalie eccentrica e vera e distanza dal fuoco */
  double m1, m2, mt, mu; /* masse dei due corpi, massa totale e massa ridotta */
  /* vettori di posizione della particella fittizia rispettivamente nel piano
   * solidale al sistema binario e nel piano del cielo */
  double ppf[3], ppfpc[3];
  /* vettori di posizione della particella di massa m1 rispettivamente nel piano
   * solidale al sistema binario e nel piano del cielo */
  double p1[3], p1pc[3];
  /* vettori di posizione della particella di massa m2 rispettivamente nel piano
   * solidale al sistema binario e nel piano del cielo */
  double p2[3], p2pc[3];
  double phi, i; /* angoli delle rotazioni */
  double d; /* distanza proiettatia nel piano del cielo */
  FILE *pianeti; /* puntatore a file */

  /* Inizializzazione delle variabili */
  periodo=10.0*3.6e3; /* 10 ore = 10*36000 secondi */
  tmin=0; /* Abbiamo supposto che al periapside t=0 */
  tmax=2*periodo;
  omega=2*PI/periodo;
  m1=5.0*GSL_CONST_MKSA_SOLAR_MASS; /* 5 masse solari */
  m2=GSL_CONST_MKSA_SOLAR_MASS; /* una massa solare */
  mt=m1+m2;
  mu=m1*m2/mt;
  /* calcolo il semiasse maggiore usando la terza legge di Keplero */
  a=cbrt(periodo*periodo*GSL_CONST_MKSA_GRAVITATIONAL_CONSTANT*mt/(4*PI*PI));
  phi=0;
  i=PI/2;
  /* la coordinata z della particella fittizia e dei due corpi è sempre nulla */
  ppf[2]=0;
  p1[2]=0;
  p2[2]=0;

  /* apro il file su cui scrivere i dati */
  pianeti=fopen("pianeti.dat","w");
  /* Cerco il valore dell'anomalia eccentrica nei PUNTI punti
   * dell'intervallo [tmin,tmax] */
  for(t=tmin;t<=tmax;t+=(tmax-tmin)/PUNTI)
    {
      psi=psi_bessel(omega*t,e); /* calolo l'anomalia eccentrica */
      r=r_bessel(omega*t,a,e);   /* calcolo la distanza dal fuoco */
      theta=anomvera(e,psi);     /* calcolo l'anomalia vera */
      ppf[0]=r*cos(theta); /* coordinata x della particella fittizia */
      ppf[1]=r*sin(theta); /* coordinata y della particella fittizia */
      p1[0]=-mu/m1*ppf[0]; /* coordinata x della particella m1 */
      p1[1]=-mu/m1*ppf[1]; /* coordinata y della particella m1 */
      p2[0]=mu/m2*ppf[0];  /* coordinata x della particella m2 */
      p2[1]=mu/m2*ppf[1];  /* coordinata y della particella m2 */
      /* calcolo le coordinate della particella fittizia e dei due corpi nel
       * piano del cielo */
      pianodelcielo(ppf, phi, i, ppfpc);
      pianodelcielo(p1, phi, i, p1pc);
      pianodelcielo(p2, phi, i, p2pc);
      /* calcolo la distanza fra i due corpi proiettata nel piano del cielo*/
      d=sqrt(ppfpc[1]*ppfpc[1]+ppfpc[2]*ppfpc[2]);
      /* scrivo su file i risultati */
      fprintf(pianeti,"%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n",t,ppf[0],ppf[1],ppf[2],
	      ppfpc[0],ppfpc[1],ppfpc[2],d);
    }
  fclose(pianeti);
  return 0;
}
