/* Nome del file sorgente: pianeti.c
 * Scopo: simulazione di un'eclissi di una stella a causa di un
 * pianeta compagno.
 * Input (hard coded): raggi e masse dei due corpi, semiasse
 * maggiore (oppure periodo, fissata una grandezza l'altra è
 * determinata dalla terza legge di Keplero) ed eccentricità
 * delle orbite, luminosità della stella, angoli di periapside
 * e di inclinazione, tempo del passaggio al periapside.
 * Unità di misura usate: CGS.
 * Output: un file di testo con i risultati della simulazione.
 * Il file è così organizzato: è suddiviso in 15 colonne, nella
 * prima c'è la fase (fase=(t-t_iniziale)/periodo); nelle 3
 * colonne successive ci sono le coordinate x, y, z iniziali
 * della particella fittizia; nelle 3 colonne successive ci
 * sono le coordinate x'', y'' e z'' della particella fittizia
 * nel piano del cielo; nelle 3 colonne successive ci sono le
 * coordinate x1'', y1'' e z1'' della stella (di massa m1) nel
 * piano del cielo; nelle 3 colonne successive ci sono le
 * coordinate x2'', y2'' e z2'' del pianeta (di massa m2) nel
 * piano del cielo; nella colonna 14 c'è la distanza fra stella
 * e pianeta proiettata nel piano del cielo e normalizzata alla
 * somma dei raggi dei due corpi; nella colonna 15 c'è il flusso
 * luminoso osservato a Terra e normalizzato a 1. Il file può
 * essere letto da un software per la realizzazione di grafici.
 * Autore: Mosè Giordano
 * Data: 10/09/2011
 */

#include <stdio.h>
#include <gsl/gsl_const_cgsm.h> /* header della GSL contenente il valore di
				 * alcune costanti fisiche in unità CGSM */
#include "libreria.h"

/* Numero di punti in cui effettuare la simulazione */
#define PUNTI 5000

int main(){
  /* Definizione delle variabili */
  double r1, r2; /* r1 = raggio stella, r2 = raggio pianeta */
  double m1, m2, mu; /* masse dei due corpi e massa ridotta */
  double a; /* semiasse maggiore dell'orbita */
  double e; /* eccentricità dell'orbita */
  double P; /* periodo dell'orbita */
  double t; /* istante di tempo */
  double t0; /* istante del passaggio al periapside */
  double tmin, tmax; /* istanti di tempo minimo e massimo in
		      * cui effettuare i calcoli */
  double lum; /* luminosità intrinseca della stella */
  double omega; /* velocità angolare media */
  double psi, theta, r; /* anomalie eccentrica e vera e distanza dal fuoco */
  /* vettori di posizione della particella fittizia rispettivamente nel piano
   * solidale al sistema binario e nel piano del cielo */
  double ppf[3], ppfpc[3];
  /* vettori di posizione, nel piano del cielo, rispettivamente
   * della particella di massa m1 e di massa m2 */
  double p1pc[3], p2pc[3];
  double phi, i; /* angoli delle rotazioni */
  double d; /* distanza proiettata nel piano del cielo fra stella e pianeta */
  double dA; /* area della stella coperta dal pianeta */
  double F; /* flusso luminoso */
  FILE *eclissi; /* puntatore a file */

  /* Inizializzazione delle variabili */
  r1=1e12;
  r2=1e11;
  m1=1.*GSL_CONST_CGSM_SOLAR_MASS; /* 1 massa solare */
  m2=0.02*GSL_CONST_CGSM_SOLAR_MASS;     /* 0.02 masse solari */
  mu=m1*m2/(m1+m2);
  a=1e13;
  e=0.8;
  /* calcolo il periodo orbitale usando la terza legge di Keplero */
  P=sqrt(4*M_PI*M_PI*a*a*a/(GSL_CONST_CGSM_GRAVITATIONAL_CONSTANT*(m1+m2)));
  t0=0; /* al periapside t=0 s */
  tmin=t0+P/2.; /* partiamo da P/2 per far vedere bene le eclissi */
  tmax=tmin+2*P;
  lum=1;
  omega=2*M_PI/P;
  phi=30./180.*M_PI;
  i=85./180.*M_PI;
  /* la coordinata z della particella fittizia è sempre nulla */
  ppf[2]=0;

  /* Effettuiamo alcuni controlli sui dati iniziali */
  if(a <= r1+r2)
    {
      fprintf(stderr,"Errore: a < R_stella + R_pianeta.\n");
      return 1;
    }
  if(r1<r2)
    {
      fprintf(stderr,"Errore: R_stella < R_pianeta.\n");
      return 1;
    }

  /* apro il file su cui scrivere i dati */
  eclissi=fopen("eclissi.dat","w");
  /* Eseguo la simulazione per ognuno dei PUNTI istanti dell'intervallo
   * di tempo [tmin,tmax] */
  for(t=tmin;t<=tmax;t+=(tmax-tmin)/PUNTI)
    {
      psi=psi_bessel(omega*(t-t0),e); /* calolo l'anomalia eccentrica */
      r=r_bessel(omega*(t-t0),a,e);   /* calcolo la distanza dal fuoco */
      theta=anomvera(e,psi);     /* calcolo l'anomalia vera */
      ppf[0]=r*cos(theta); /* coordinata x della particella fittizia */
      ppf[1]=r*sin(theta); /* coordinata y della particella fittizia */
      /* calcolo le coordinate della particella fittizia e dei due corpi nel
       * piano del cielo */
      pianodelcielo(ppf, phi, i, ppfpc);
      vettore_scalare(3,ppfpc,p1pc,-mu/m1);
      vettore_scalare(3,ppfpc,p2pc,mu/m2);
      d=hypot(ppfpc[1],ppfpc[2]); /* calcolo la distanza proiettata */
      dA=area_coperta(r1, r2, d, p1pc[0], p2pc[0]);
      F=flusso(4,lum,r1,dA);
      /* scrivo su file i risultati */
      fprintf(eclissi,"%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n",
	      (t-t0)/P,ppf[0],ppf[1],ppf[2],ppfpc[0],ppfpc[1],ppfpc[2],
	      p1pc[0],p1pc[1],p1pc[2],p2pc[0],p2pc[1],p2pc[2],d/(r1+r2),F);
    }
  fclose(eclissi);
  return 0;
}
