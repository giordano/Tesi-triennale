#include "kepler_functions.h"

/* Funzione di cui vogliamo trovare le radici. Il primo
 * argomento è l'anomalia eccentrica, il secondo argomento
 * è l'eccentricità, il terzo è l'anomalia media, cioè il
 * prodotto della velocità angolare media e del tempo.
 */
double f(double psi, double e, double phi)
{
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
  double psi=phi; /* anomalia eccentrica. Punto iniziale = phi */
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
 * usando il metodo dei coefficienti di Bessel. Il primo argomento
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
 * fuoco al tempo t, calcolata con il metodo dei coefficienti
 * di Bessel. Il primo argomento è l'anomalia media, il
 * secondo il semiasse maggiore, il terzo l'eccentricità
 */
double r_bessel(double phi, double semiasse, double e)
{
  int n;
  double distanza=semiasse*(1+e*e/2.);
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

/* Funzione che trasforma le coordinate del punto Qa del sistema di riferimento
 * intrinseco al sistema binario nelle coordinate del punto Qb visto da un
 * osservatore nel proprio piano del cielo. Abbiamo sfruttato la formula (1.97)
 * di pagina 23 della tesi e le trasformazioni discusse nel capitolo 4 del
 * Goldstein, Poole e Safko (vedi la bibliografia). `phi' e `i' sono gli angoli
 * delle rotazioni effettuate.
 */
void pianodelcielo(double Qa[3], double phi, double i, Qb[3])
{
  Qb[0]=sin(i)*(Qa[0]*cos(phi)-Qa[1]*sin(phi))+Qa[2]*cos(i);
  Qb[1]=Qa[0]*sin(phi)+Qa[1]*cos(phi);
  Qb[2]=cos(i)*(Qa[1]*sin(phi)-Qa[0]*cos(phi))+Qa[2]*sin(i);
}
