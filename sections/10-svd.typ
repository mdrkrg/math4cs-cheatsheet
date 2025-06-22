#import "../utils.typ": *

= SVD decomposition

Given $ub(A) in RR^(m times n)$, the *singular value decomposition* of $ub(A)$ is
$
ub(A) = ub(U) ub(Sigma) ub(V)^trans
$
- Original Matrix $ub(A) in RR^(m times n)$
  - Role: Represents a linear transformation from an $n$-d space to an $m$-d space.
  - Characteristics: A can be singular (non-invertible) or non-singular, rectangular or square. The SVD exists for all such matrices.
- Left Singular Vectors $ub(U) in RR^(m times m)$
  - Orthogonal: $ub(U)^trans ub(U) = ub(I)_(m times m)$, columns form an orthonormal basis for $RR^m$.
  - The columns of $ub(U)$ are the *eigenvectors* of the matrix $ub(A) ub(A)^trans$.
  - Basis for column space, *the rotation of the final output space*.
    //: The columns of U corresponding to the non-zero singular values form an orthonormal basis for the column space (range) of A.
- Singular Values $ub(Sigma) in RR^(m times n)$ (rectangular diagonal matrix)
  - The main diagonal contains the *singular values* $sigma_1 >= sigma_2 >= dots.c >= sigma_min(m,n) >= 0$ of $ub(A)$ arranged in *descending order*, and zeros everywhere else.
  - $sigma_i = sqrt(lambda_i (A^trans A)) = sqrt(lambda_i (A A^trans))$.
  - Rank: The number of non-zero singular values $= "rank" ub(A)$.
  - Magnitude of transformation, *the scaling along the principal axes*.
    //: The singular values represent the "strength" or "magnitude" of the linear transformation along the directions specified by the singular vectors. A larger singular value means more stretching.
- Transpose of Right Singular Vectors $ub(V)^trans in RR^(n times n)$ 
  - Orthogonal: $ub(V)^trans ub(V) = ub(I)_(n times n)$, columns form an orthonormal basis for $RR^n$.
  - The columns of $ub(V)$ are the *eigenvectors* of the matrix $ub(A)^trans ub(A)$.
  - Basis for row space / null space,
    *the initial rotation of the input space*.
    //: The columns of V corresponding to the non-zero singular values form an orthonormal basis for the row space of A. The columns of V corresponding to the zero singular values form an orthonormal basis for the null space of A.

== Condition number of an invertible matrix $ub(A)$ under the SVD

$
norm(ub(A))_2 = max_i {sigma_i}, "where" sigma_i "is the" i"-th singular value".
$

The condition number of $ub(A)$ with respect to $norm(dot.c)_2$ is
$
"cond" ub(A) = sigma_max / sigma_min.
$

== Computing SVD decomposition

The columns of $ub(V)$ are the eigenvectors of $ub(A)^trans ub(A)$, can be computed using eigenvector algorithms.
$ub(A) = ub(U) ub(Sigma) ub(V)^trans => ub(A) ub(V) = ub(U) ub(Sigma)$,
the columns of $ub(U)$ corresponding to nonzero singular values in $ub(Sigma)$ are normalized columns of $ub(A) ub(V)$.
The remaining columns satisfy $ub(A) ub(A)^trans bold(u)_i = bold(0)$, computed using the LU factorization.

1. Compute the eigenvalues and eigenvectors of $ub(A)^trans ub(A) in RR^(n times n)$. Normalize eigenvectors to unit length. They form the columns of $ub(V)$. Or $ub(A) ub(A)^trans in RR^(m times m)$ whose eigenvectors form the columns of $ub(U)$.
2. Construct the $ub(Sigma) in RR^(m times n)$, whose main diagonal are singular values $sigma_1, sigma_2, ..., sigma_min(m, n)$ in *descending order*. All other entries are zero.
  - $sigma_i = sqrt(lambda_i)$, where $lambda_i$ are the eigenvalues of $ub(A)^trans ub(A)$.
3. $ub(U)$ can be computed using
  $ub(A) bold(v)_i = sigma_i bold(u)_i => bold(u)_i = 1 / sigma_i ub(A) bold(v)_i.$
  If $m > k = "rank"(ub(A))$, find the remaining $m - k$ orthonormal vectors to complete the basis for $RR^m$. These additional vectors form an orthonormal basis for the null space of $ub(A)^trans$. You can find them by:
  - Finding the eigenvectors of $ub(A) ub(A)^trans$ corresponding to the zero eigenvalues.
  - Or, by finding a basis for the null space of $ub(A)^trans$ and then orthonormalizing them (e.g., using Gram-Schmidt process).

== Solving linear systems using SVD

If $ub(A)$ square and invertible,
$bold(x) = ub(A)^(-1) bold(b)
= ub(V) ub(Sigma)^(-1) ub(U)^trans bold(b),
ub(Sigma)^(-1)_(i i) = 1 \/ sigma_i.
$

=== Pseudoinverse of $ub(A) = ub(U) ub(Sigma) ub(V)^trans in RR^(m times n) => ub(A)^+ = ub(V) ub(Sigma)^+ ub(U)^trans in RR^(n times m)$

- $ub(Sigma)_(i i)^+ = 1 \/ sigma_i$ if $sigma_i > 0$, $0$ if $sigma_i = 0$
- $ub(A)$ *square and invertible* $=> ub(A)^+ = ub(A)^(-1)$
- $ub(A)$ *overdetermined* $m > n$ $=>$ $ub(A)^+ bold(b)$ gives the least-squares solution to $ub(A) bold(x) approx ub(b)$
- $ub(A)$ *underdetermined* $m < n$ $=>$ $ub(A)^+ bold(b)$ gives the least-norm solution
  $min norm(bold(x))_2^2 "s.t." ub(A) bold(x) = bold(b)$
  ($ub(A)^+ - ub(A)^trans (ub(A) ub(A)^trans)^(-1)$)

#[
#let outer-product-form = $ub(A)
= sum_(i=1)^l sigma_i bold(u)_i bold(v)_i^trans,
l equiv min{m, n}$

== Outer product form #outer-product-form
]

- Outer product: $bold(u) times.circle bold(v) equiv bold(u) bold(v)^trans$
$
ub(A) bold(x) = sum_(i=1)^l sigma_i (bold(v)_i dot.c bold(x)) bold(u)_i,
ub(A)^+ = sum_(sigma_i != 0) (bold(v)_i bold(u)_i^trans) / sigma_i.
$

=== Eckart-Young theorem (low-rank approximation)

The best rank-$k$ approximation $ub(A)_k$ to $ub(A)$
is obtained by keeping the $k$ largest singular values and their
corresponding singular vectors: $ub(A)_k = sum_(i=1)^k sigma_i bold(u)_i bold(v)_i^trans$.
- Minimizes $norm(ub(A) - ub(A)_k)_"Fro"$ and $norm(ub(A) - ub(A_k))_2$,
  where $norm(ub(A))_"Fro"^2 = sum_i sigma_i^2$

=== Tikhonov solution with SVD: $(ub(A)^trans ub(A) + alpha ub(I)) bold(x) = ub(A)^trans bold(b)$

Solution using SVD analysis: $bold(hat(x)) = ub(V) ub(D) ub(U)^trans bold(b), ub(D)_(i i) = sigma_i \/ (sigma_i^2 + alpha^2)$.
- $alpha$ effectively dampens the effect of small singular values (which cause instability) by modifying how they contribute to the solution.
