#include <Rcpp.h>
using namespace Rcpp;

//--------------------------------------------------------------------

//' Minmax Normalization
//'
//' For each column of a matrix, it substracts its minimum and divide
//' by the length of its range
//'
//' An error is returned if there is at least one column whose values
//' are all the same.
//' @param mat A numeric matrix.
//' @return The normalized matrix, with a vector with ' column
//' minimums and a vector with the column range lengths as attributes.
//' @author Guillermo Basulto-Elias
//' @examples
//' mat <- matrix(c(0, 1, 2,
//'                 3, 4, 5,
//'                 3, 2, 1),
//'                 nrow = 3, byrow = TRUE)
//'   drewcurves:::minmax(mat)
//'   
//' \dontrun{
//'     mat <- matrix(c(0, pi, 1, 2,
//'                     3, pi, 4, 5,
//'                     3, pi, 2, 1),
//'                     nrow = 3, byrow = TRUE)
//'     drewcurves:::minmax(mat)
//'   }
// [[Rcpp::export]]
NumericMatrix minmax(const NumericMatrix & mat)
{

  int N = mat.nrow(), M = mat.ncol(), i, j;
  NumericMatrix out_mat(N, M);
  NumericVector colmins(M), colmaxs(M), rangelengths(M);

  // Initialize vectors
  for (j = 0; j < M; j++)
    {
      colmins[j] = mat(0, j);
      colmaxs[j] = mat(0, j);
    }

  // Compute minimum and maximum by column
  for (j = 0; j < M; j++)
    {
      for (i = 1; i < N; i++)
	{
	  if (mat(i, j) < colmins[j]) colmins[j] = mat(i, j);
	  if (mat(i, j) > colmaxs[j]) colmaxs[j] = mat(i, j);
	}
      rangelengths[j] = colmaxs[j] - colmins[j];
    }


  // Check that rangelengths  has no zero entries,  otherwise we would
  // be dividing by zero.
  for (j = 0; j < M; j++)
    {
      if (rangelengths[j] == 0)
	{
	  stop("All the columns must have at least two different values.");
	}
    }
  
  // Normalize each column
  for (j = 0; j < M; j++)
    {
      for (i = 0; i < N; i++)
	{
	  out_mat(i, j) = (mat(i, j) - colmins[j])/rangelengths[j];
	}
    }

  // Add attributes: minimum and range length.
  out_mat.attr("colmin") = colmins;
  out_mat.attr("range_lengths") = rangelengths;
  
  return out_mat;
}


