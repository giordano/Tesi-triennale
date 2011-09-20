#include "libreria.h"

/* Funzione di cui vogliamo trovare le radici. Il primo
 * argomento è l'anomalia eccentrica, il secondo argomento
 * è l'eccentricità, il terzo è l'anomalia media, cioè il
 * prodotto della velocità angolare media e del tempo.
 */
double f(double psi, double e, double phi)
{
  /* phi deve trovarsi nell'intervallo [0,2pi] */
  phi=fmod(phi,2*M_PI);
  return psi-e*sin(psi)-phi;
}

/* Funzione che restituisce la derivata rispetto a x del
 * coefficiente di Bessel J_n(x) sfruttando le proprietà dei
 * coefficienti di Bessel. Il primo argomento è l'ordine del
 * coefficiente di Bessel, il secondo è il suo argomento
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
  double psi; /* anomalia eccentrica. */
  /* phi deve trovarsi nell'intervallo [0,2pi] */
  phi=fmod(phi,2*M_PI);
  /* punto iniziale per anomalia eccentrica = anomalia media */
  psi=phi;
  /* Se il valore assoluto della funzione valutata nel punto
   * iniziale è maggiore della precisione desiderata utilizzo
   * il metodo di Newton per cercare un nuovo punto.
   */
  while(fabs(f(psi,e,phi))>PRECISIONE)
    psi-=(psi-e*sin(psi)-phi)/(1-e*cos(psi));
  return psi;
}

/* Funzione che restituisce il valore dell'anomalia eccentrica
 * psi in corrispondenza dell'anomalia media phi calcolata
 * usando il metodo dei coefficienti di Bessel. Il primo
 * argomento è l'anomalia media, il secondo l'eccentricità
 */
double psi_bessel(double phi, double e)
{
  int n;
  double psi;
  /* phi deve trovarsi nell'intervallo [0,2pi] */
  phi=fmod(phi,2*M_PI);
  psi=phi;
  for(n=1;n<=MAX_BESSEL;n++)
    psi+=2*gsl_sf_bessel_Jn(n,n*e)*sin(n*phi)/n;
  return psi;
}

/* Funzione che restituisce il valore della distanza r da
 * fuoco al tempo t, calcolata con il metodo dei coefficienti
 * di Bessel. Il primo argomento è l'anomalia media, il
 * secondo il semiasse maggiore, il terzo l'eccentricità
 */
double r_bessel(double phi, double semiasse, double e)
{
  int n;
  double distanza=semiasse*(1+e*e/2.);
  /* phi deve trovarsi nell'intervallo [0,2pi] */
  phi=fmod(phi,2*M_PI);
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
  if(psi<=M_PI)
    return 2*atan(sqrt((1+e)/(1-e))*tan(psi/2));
  else
    return 2*(atan(sqrt((1+e)/(1-e))*tan(psi/2))+M_PI);
}

/* Funzione che trasforma le coordinate del punto Qa del
 * sistema di riferimento intrinseco al sistema binario
 * nelle coordinate del punto Qb visto da un osservatore
 * nel proprio piano del cielo. Abbiamo sfruttato la formula
 * (1.97) di pagina 23 della tesi e le trasformazioni discusse
 * nel capitolo 4 del Goldstein, Poole e Safko (vedi la
 * bibliografia). `phi' è l'angolo fra l'asse x' e l'asse x,
 * `i' è l'angolo fra l'asse z'' e x'', come spiegato nella tesi.
 */
void pianodelcielo(double Qa[3], double phi, double i, double Qb[3])
{
  Qb[0]=sin(i)*(Qa[0]*cos(phi)-Qa[1]*sin(phi))+Qa[2]*cos(i);
  Qb[1]=Qa[0]*sin(phi)+Qa[1]*cos(phi);
  Qb[2]=cos(i)*(Qa[1]*sin(phi)-Qa[0]*cos(phi))+Qa[2]*sin(i);
}

/* Funzione che calcola il prodotto fra il vettore `a' e lo
 * scalare `c', salvando il risultato nel vettore `b'. Il primo
 * argomento è la lunghezza dei due vettori `a' e `b'.
 */
void vettore_scalare(int n, double a[], double b[], double c)
{
  int i;
  for (i=0; i<n; i++)
    b[i]=c*a[i];
}

/* Le funzioni seguenti servono per le simulazioni di transiti. */

/* Funzione che restituisce l'area di di sovrapposizione fra
 * i due corpi. `r1' è il raggio della stella, `r2' del pianeta,
 * `d' è la loro distanza proiettata, `x1' e `x2' sono le
 * coordinate, rispettivamente della stella e del pianeta, nel
 * piano del cielo dell'osservatore.
 */
double area_coperta(double r1, double r2, double d, double x1, double x2)
{
  double theta1, theta2; /* vedi Figura 3.5 della tesi */
  double dA; /* area coperta */
  theta1=2*acos((r1*r1-r2*r2+d*d)/(2*r1*d));
  theta2=2*acos((r2*r2-r1*r1+d*d)/(2*r2*d));

  /* se la stella è davanti al pianeta rispetto all'osservatore... */
  if(x1 >= x2)
    /* ...non si verifica l'eclissi (l'area coperta cioè è nulla) */
    dA=0;
  else
    {
      if(d > r1+r2)
	dA=0;
      else if(r1-r2 <= d)
	dA=r1*r1/2*(theta1-sin(theta1))+r2*r2/2*(theta2-sin(theta2));
      else
	dA=M_PI*r2*r2;
    }
  return dA;
}

/* Funzione che restituisce il valore del flusso di una stella.
 * Vedi equazione (3.17), pag. 41. `f' è il fattore geometrico,
 * `lum' è la luminosità intrinseca della stella, `r' è il raggio
 * della stella, `dA' è l'area coperta dal pianeta. Se si passa
 * alla funzione f=4, il risultato sarà normalizzato a `lum'.
 */
double flusso(double f, double lum, double r, double dA)
{
  return f*lum*(1-dA/(M_PI*r*r))/4;
}
