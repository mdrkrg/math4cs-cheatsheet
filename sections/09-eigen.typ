#import "../utils.typ": *

= Eigenvectors


$ub(A) in RR^(n times n)$, a non-zero $bold(x) != 0$ is an *eigenvector* if
$ub(A) bold(x) = lambda bold(x)$ for some scalar $lambda$.
- $lambda$ is the eigenvalue corresponding to $bold(x)$
- Eigenvectors define directions that are only scaled by linear transformation $ub(A)$
- Scale doesn't matter: $c bold(x), c != 0$ is also eigenvector (often constraint $norm(x)_2 = 1$)
When $ub(A)$ is symmetric, the eigenvectors of $ub(A)$ are the critical points (临界点, 导数为 0) of
$bold(x)^trans ub(A) bold(x)$ under the constraint $norm(bold(x))_2 = 1$.

== Characteristic polynomial: $p_ub(A) (lambda) = det(ub(A) - lambda ub(I)) = 0 => lambda_1, ..., lambda_n$

== Spectrum: the set of all eigenvalues of $ub(A)$
- *Spectral radius*:
  $ub(A) in RR^(n times n)$ with eigenvalues $lambda_i$,
  $rho(ub(A)) = max_(1 <= i <= n) |lambda_i|$

== Statistical motivation

- Goal: Find a lower-dimensional subspace (e.g., a line / principal axis) that best represents a collection of data points $x_i$.
- *Minimize projection error*:
  $min_bold(hat(v)) sum_i norm(bold(x)_i - "proj"_bold(hat(v)) bold(x)_i)_2^2
  "s.t." norm(bold(hat(v)))_2 = 1$.
- $<=> max norm(ub(X)^trans bold(hat(v)))_2^2
  = bold(hat(v))^trans ub(X) ub(X)^trans bold(hat(v))
  "s.t." norm(bold(hat(v)))_2^2 = 1$, where the columns of $ub(X)$ are $bold(x)_i$.
- The solution $bold(hat(v))$ is the eigenvector of $ub(X) ub(X)^trans$
  with the largest eigenvalue,
  known as the first *principal component* of the dataset.

== Properties of $ub(A) in CC^(n times n)$

- Has at least one (complex) eigenvector
- Eigenvectors with *distinct* eigenvalues are *linearly independent*
- *Diagonalizable* if has $n$ linearly independent eigenvectors,
  $ub(A) = ub(X) ub(D) ub(X)^(-1)$
- Hermitian $ub(A) = ub(A)^upright(H)$ (symmetric if $ub(A)$ is real): *real* eigenvalues, *orthogonal* eigenvectors with distinct eigenvalues
- *Spectral theorem*: Hermitian $ub(A)$ has $n$ *orthonormal eigenvectors*,
  $ub(A) = ub(X) ub(D) ub(X)^trans$, any $bold(y) in RR^n$ can be decomposed into a linear combination of them
- Solving $ub(A) bold(y) = bold(b)$,
  $bold(b) = sum_i c_i bold(x)_i$, where $c_i = bold(b) dot.c bold(x)_i$ by orthonormality: If $ub(A) = ub(X) ub(D) ub(X)^(-1)$,
    then $ub(A)^(-1) = ub(X) ub(D)^(-1) ub(X)^(-1) = ub(X) ub(D)^(-1) ub(X)^trans$,
    $bold(y) = ub(A)^(-1) bold(b) = sum_i (c_i \/ lambda_i) bold(x)_i$

== Power iteration: $ub(A) in RR^(n times n)$ diagonalizable, all real eigenvalues nonzero

Given initial guess vector $bold(q)^((0))$ where $norm(bold(q)^((0)))_2 = 1$,
$
bold(z)^((k)) = ub(A) bold(q)^((k-1)),
bold(q)^((k)) = bold(z)^((k)) / norm(bold(z)^((k)))_2,
lambda^((k)) = (bold(q)^((k)), ub(A) bold(q)^((k))).
$

- The (main, largest) eigenvalue $lambda_1 = lambda^((k))$ and eigenvector $bold(x)_1 = bold(q)^((k))$.

// ```py
// def power_iteration(mat_A, x0, tol=1e-3):
//     """x0 first guess(non-zero)"""
//     x0 = x0 / np.linalg.norm(x0) # normalised
//     lambda0 = np.inner(np.matmul(mat_A, x0).reshape(3), x0.reshape(3)) # inner product
//     while True:
//         x1 = np.matmul(mat_A, x0)
//         x1 = x1 / np.linalg.norm(x1) # normalised
//         lambda1 = np.inner(np.matmul(mat_A, x1).reshape(3), x1.reshape(3))
//         x0 = np.copy(x1)
//         if abs(lambda1 - lambda0) < tol:
//             return {'eigen_val': lambda1, 'eigen_vec': x0.tolist()}
//         else:
//             lambda0 = lambda1
// ```

== Other iteration (norm is often L2-norm but others can be used)

- Inverse (*smallest* eigenvalue):
  $bold(z)^((k)) = ub(A)^(-1) bold(q)^((k-1)),
  bold(q)^((k)) = bold(z)^((k)) / norm(bold(z)^((k)))$.
- Inverse with LU: 
  $"solve" ub(L) bold(y)^((k)) = bold(q)^((k-1)), "solve" ub(U) bold(z)^((k)) = bold(y)^((k)),
  bold(q)^((k)) = bold(z)^((k)) / norm(bold(z)^((k)))$.
- Shifted ... (closest to $sigma$):
  $(ub(A) - sigma ub(I)) bold(q) = (lambda - sigma) bold(q),
  bold(q)^((k+1))
  = ((ub(A) - sigma ub(I))^(-1) bold(q)^((k))) / norm((ub(A) - sigma ub(I))^(-1) bold(q)^((k)))$.
- Rayleigh quotient:
  $bold(q)^((k))
  = ((ub(A) - sigma^((k)) ub(I))^(-1) bold(q)^((k-1)))
  / norm((ub(A) - sigma^((k)) ub(I))^(-1) bold(q)^((k-1)))_2,
  sigma^((k+1))
  = ((bold(q)^((k)))^trans ub(A) bold(q)^((k))) / norm(bold(q)^((k)))_2^2$.
