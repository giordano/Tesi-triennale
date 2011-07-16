#include <math.h>
#include <gsl/gsl_sf_bessel.h>

/* Numero di iterazioni da compiere con il metodo di Bessel
 * prima di fermarsi */
#define MAX_BESSEL 200
/* Specifico il valore della precisione desiderata */
#define PRECISIONE 1e-12

double f(double, double, double);
double diff_besselj(int, double);
double psi_newton(double, double);
double psi_bessel(double, double);
double r_bessel(double, double, double);
double r(double, double, double);
double anomvera(double, double);
void pianodelcielo(double Qa[3], double phi, double i, double Qb[3]);
