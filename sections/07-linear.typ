#import "../utils.typ": *

= Analyzing linear systems

== Regression: predict $f(bold(x))$ for a new $bold(x)$ given a set of known datapoints

Generalized linear form:
$f(bold(x)) = a_1 phi_1 (bold(x)) + dots.c + a_p phi_p (bold(x))$.
Given $m$ datapoints $(x^((k)), y^((k)))$ and $p$ parameters,
form linear system $ub(Phi) bold(a) = bold(y)$:
- $ub(Phi) in RR^(m times p), ub(Phi)_(k j) = phi_j (x^((k)))$ linear combination of basis functions
  - Polynomial regression: $phi_i (x) = x^(i-1)$, $ub(Phi)$ is a Vandermonde matrix
- $bold(a) in RR^(p times 1)$ unknown parameters
- $bold(y) in RR^(m times 1)$ observed outputs

== Least-squares

Problem: When $ub(A) bold(x) = bold(b)$ has no exact solution
(an overdetermined system,
often because $ub(A) in RR^(m times n)$ with $m > n$),
find an approximation $bold(hat(x))$
such that $ub(A) bold(hat(x)) approx bold(b)$. \
Least-squares solution: *Minimize the norm's square* of the residual
$norm(bold(b) - ub(A) bold(x))_2^2$.
With normal equations theorm (4.1),
this is equivalent to solving $ub(A)^trans ub(A) bold(x) = ub(A)^trans bold(b)$.
- $ub(A)^trans ub(A)$ (Gram matrix): If $ub(A)$ has linearly independent columns, then $ub(A)^trans ub(A)$ is invertible, and least-squares have a unique solution.

=== Polynomial least-squares (extension for convenience)

For $m + 1$ data points, with polynomial
$P_n (x) = sum_(i=0)^n a_i x^i$ of degree $n < m - 1$,
the minimization problem is
$E := sum^m _(i=0) [f(x_i) - P_n (x_i)]^2$. Which requires
$
frac(partial E, partial a_k) =
sum^m _(i=0) [f(x_i) - a_n x_i^n - dots.c - a_1x_i - a_0]x_i^k = 0. \
"Solution": mat(delim: "[",
  sum_(i=0)^m x_i^0, dots.c, sum_(i=0)^m x_i^n;
  dots.v, dots.down, dots.v;
  sum_(i=0)^m x_i^n, dots.c, sum_(i=0)^m x_i^(2n);
)
mat(delim: "[",
  a_0; dots.v; a_n;
)
=
mat(delim: "[",
  sum_(i=0)^m y_i x_i^0;
  dots.v;
  sum_(i=0)^m y_i x_i^n;
)
$

=== Linear least-squares $f(x) = a_0 + a_1 x$ (seen before in finals)

$a_0 = (
  sum_(i=0)^m x_i^2 sum_(i=0)^m y_i - sum_(i=0)^m x_i y_i sum_(i=0)^m x_i
) / (
  (m + 1) (sum_(i=0)^m x_i^2) - (sum_(i=0)^m x_i)^2
),
a_1 = (
  (m + 1) sum_(i=0)^m x_i y_i -  sum_(i=0)^m x_i sum_(i=0)^m y_i
) / (
  (m + 1) (sum_(i=0)^m x_i^2) - (sum_(i=0)^m x_i)^2
)$.

== Tikhonov regulation: adds a penalty for desirable (smaller) solutions

$
min_bold(x) norm(ub(A) bold(x) - bold(b))_2^2
+ underbrace(alpha norm(bold(x))_2^2\, (0 < alpha << 1), "Tikhonov regularizer"),
"solution:"
(ub(A)^trans ub(A) + alpha ub(I)) bold(x) = ub(A)^trans bold(b).
$
- $ub(A)^trans ub(A) + alpha ub(I)$ is positive definite (invertible) if $alpha > 0$
- Increasing $alpha$ increases the penalty, making solution L2 norm smaller but potentially larger residuals $norm(ub(A) bold(x) - bold(b))_2^2$

=== Homework problem 4.4 (for reference)

Suppose $ub(A) in RR^(m times n)$ has full rank, where $m < n$. Show that taking $bold(x_s) = ub(A)^trans (ub(A) ub(A)^trans)^(-1) bold(b)$ solves the following optimization problem, i.e., the least-norm solution:
$min_(bold(x)) norm(bold(x))_2 "subject to" ub(A) bold(x) = bold(b).$ \
Hint: That is to prove that $bold(x_s)$ is the solution with the smallest norm among all feasible solutions ($norm(bold(x_s))_2 < norm(bold(x))_2 , forall bold(x) != bold(x_s)$).
// You can write $norm(bold(x))_2$ as $norm((bold(x) - bold(x_s)) + bold(x_s))_2$ and expand it to observe its terms. It is necessary to prove that $bold(x_s)$ and $(bold(x) - bold(x_s))$ are orthogonal.

+
  $ub(A) bold(x_s) = ub(A) ub(A)^trans (ub(A) ub(A)^trans)^(-1) bold(b) = bold(b)$,
  therefore $bold(x_s)$ is one solution to the optimization problem (satisfies the constraint).
+ $bold(x_s)_(m times 1)$ lies in the row space of $ub(A)$.
  $ub(A)(bold(x) - bold(x_s)) = bold(b) - bold(b) = bold(ub(0))$,
  therefore, $(bold(x) - bold(x_s))$ is in the null space of $ub(A)$.
  $(bold(x) - bold(x_s))$ and $bold(x_s)$ are orthogonal.
+ Since $(bold(x) - bold(x_s))$ and $bold(x_s)$ are orthogonal,
  $norm(bold(x))_2^2 = norm((bold(x) - bold(x_s)) + bold(x_s))_2^2
  = norm(bold(x) - bold(x_s))_2^2 + norm(bold(x_s))_2^2$.
  Since $norm(bold(x) - bold(x_s))_2^2 >= 0$, $norm(bold(x))_2^2 >= norm(bold(x_s))_2^2$.
  Therefore, $bold(x_s)$ is the solution with smallest norm.


== Cholesky factorisation: Symmetric $ub(C) > 0 "(PD)" => ub(C) = ub(L) ub(L)^trans$

// NOTE: since calculation is not needed
// ```py
// for i in range(n): # The Cholesky-Banachiewicz algorithm
//     for j in range(i + 1): # A is the source matrix
//         total = 0.0          # n is dimension size
//         for k in range(j):   # L is initialized n * n zero
//             total += L[i][k] * L[j][k]
//         L[i][j] = sqrt(A[i][i] - total) if i == j \
//                   else 1.0 / L[j][j] * (A[i][j] - total)
// ```

Constructing a forward--substitution matrix $ub(E)$ from $ub(C)$:
$
ub(C) =
mat(
c_(11), bold(v)^trans;
bold(v), over(ub(C), t: ~);
),
ub(E) =
mat(
1 / sqrt(c_(11)), bold(ub(0))^trans;
bold(r), ub(I)_((n-1) times (n-1));
),
"where" bold(r) "satisfies" r_(i-1) c_(1 1) = -c_(i 1)
\
-->
ub(E) ub(C) =
mat(
sqrt(c_(11)), (bold(v)^trans) / sqrt(c_(11));
bold(ub(0)), ub(D);
),
ub(E) ub(C) ub(E)^trans =
mat(
1, bold(ub(0))^trans;
bold(ub(0)), ub(D);
).
$
Repeat the process on $ub(D)$, until the last dimension. \
Finally,
$ub(E)_k dots.c ub(E)_2 ub(E)_1 ub(C) ub(E)_1^trans ub(E)_2^trans dots.c ub(E)_k^trans
= ub(I)_(n times n),
ub(L) equiv ub(E_1)^(-1) ub(E_2)^(-1) dots.c ub(E_k)^(-1)$.

== Matrix condition number

The condition number of $ub(A) in RR^(n times n)$ concerning a given matrix norm $norm(dot.c)$ is
$
"cond" ub(A) equiv norm(ub(A)) norm(ub(A)^(-1)).
$
If $ub(A)$ is not invertible, we take $"cond" ub(A) equiv infinity$.
