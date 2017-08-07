#include <Rcpp.h>
using namespace Rcpp;

//--------------------------------------------------------------------

//' Compute Fourier Series
//'
//' Computes Fourier series required by Andrews curves.
//' @param mat Data matrix of size nxp
//' @param t Vector of size m where the series is being evaluated.
//' @param type Type of curve.
//' @return A nxm matrix where each row represents a curve.
//' @export
// [[Rcpp::export]]
NumericMatrix compute_fourier_series(NumericMatrix mat,
                                     NumericVector t, int type)
{
  int l, k, n, K = t.size(), N = mat.nrow(), M = mat.ncol(),
  L = (M - 1)/2;
  double arg;
  NumericMatrix out(K, N);
  
  for (k = 0; k < K; k++)
  {
    for (n = 0; n < N; n++)
    {
      l = 0;
      out(k, n) = mat(n, 0)/pow(2.0, 0.5);
      while (l < L)
      {
        l++;
        arg = l*t[k];
        out(k, n) +=
          mat(n, 2*l - 1)*sin(arg) + mat(n, 2*l)*cos(arg);
      }
      if (M % 2 == 0)
      {
        out(k, n) += mat(n, M - 1)*sin(l*M/2);
      }
    }
  }
  return out;
}


