#import "../utils.typ": *

= QR decomposition

Decomposition of $ub(A) in RR^(m times n)$, where $m >= n$ and $ub(A)$ has *full column rank*, into $ub(A) = ub(Q) ub(R)$. *Full QR decomposition*:
- $ub(Q) in RR^(m times m)$ with *orthonormal columns* ($ub(Q)^trans ub(Q) = ub(I)$)
- $ub(R) in RR^(m times n)$ is an *upper triangular matrix*
- *Reduced QR decomposition*: $ub(Q) in RR^(m times n)$ and $ub(R) in RR^(n times n)$

== Orthogonality

Vectors ${bold(v_1), ..., bold(v_k)}$ is *orthonormal* if $norm(bold(v_i)) = 1, forall i$ and $bold(v_i) dot.c bold(v_j) = 0, forall i != j$.
- *Orthogonal matrix*: A square matrix whose columns are orthonormal.

== Gram-Schmidt methods

=== Projections

The *projection* of $bold(b)$ onto $bold(a)$
($"proj"_bold(a) bold(b) parallel bold(a)$,
residual: $bold(b) - "proj"_bold(a) bold(b) perp bold(a)$):

$
"proj"_bold(a) bold(b)
equiv c bold(a)
= (bold(a) dot.c bold(b)) / (bold(a) dot.c bold(a)) bold(a)
= (bold(a) dot.c bold(b)) / norm(bold(a))_2^2 bold(a), c = (bold(a) dot.c bold(b)) / norm(bold(a))_2^2.
$

=== Gram-Schmidt orthogonalization

#pseudocode-list(
  booktabs: true,
  title: [
    *Gram-Schmidt*($bold(v)_1, ..., bold(v)_k$)
    - Computes an orthonormal basis $bold(hat(a))_1, ..., bold(hat(a))_k$
      for span ${bold(v)_1, ..., bold(v)_k}$ 标准正交基
    - Assumes $bold(v)_1, ..., bold(v)_k$ are linearly independent
  ])[
  + $bold(hat(a))_1 := bold(v)_1 \/ norm(bold(v)_1)_2$ Nothing to project out of the first vector
  + *for* $i := 2 .. k$
    + $bold(p) := bold(0)$ Projection of $bold(v_i)$ onto span ${bold(hat(a))_1, ..., bold(hat(a))_(i-1)}$
    + *for* $j := 1 .. i - 1$
      + $bold(p) := bold(p) + (bold(v)_i dot.c bold(hat(a))_j) bold(hat(a))_j$ Projecting onto orthonormal basis
    + $bold(r) := bold(v)_i - bold(p)$ Residual is orthogonal to current basis
    + $bold(hat(a))_i := bold(r) \/ norm(bold(r))_2$ Normalize this residual and add it to the basis
  + *return* ${bold(hat(a))_1, ..., bold(hat(a))_k}$

  + *for* $i := 1 .. k$ alt: *Modified-Gram-Schmidt*($bold(v)_1, ..., bold(v)_k$) (numerically stable)
    + $bold(hat(a))_i := bold(v)_i \/ norm(bold(v)_i)_2$ Normalize the current vector and store in the basis
    + *for* $j := i + 1 .. k$
      + $bold(v)_j := bold(v)_j - (bold(v)_j dot.c bold(hat(a))_i) bold(hat(a))_i$ Project $bold(hat(a))_i$ out of the remaining vectors
  + *return* ${bold(hat(a))_1, ..., bold(hat(a))_k}$
]

// #pseudocode-list(
//   booktabs: true,
//   title: [
//     Modified-Gram-Schmidt($bold(v)_1, ..., bold(v)_k$) (numerically stable)
//   ])[
//   + *for* $i := 1 .. k$
//     + $bold(hat(a))_i := bold(v)_i \/ norm(bold(v)_i)_2$ Normalize the current vector and store in the basis
//     + *for* $j := i + 1 .. k$
//       + $bold(v)_j := bold(v)_j - (bold(v)_j dot.c bold(hat(a))_i) bold(hat(a))_i$ Project $bold(hat(a))_i$ out of the remaining vectors
//   + *return* ${bold(hat(a))_1, ..., bold(hat(a))_k}$
// ]

=== Gram-Schmidt orthogonalization used in QR factorization

Let $ub(Q)$ be the output of the G-S orthogonalization performed on columns of $ub(A)$,
$
ub(Q) equiv "Gram-Schmidt"(ub(A)), ub(R) = ub(Q)^trans ub(A).
$

=== Alternative: view orthogonalization steps as column operations
$ub(Q) = ub(A) ub(E)_1 ub(E_2) dots.c ub(E)_n
=> ub(A) = ub(Q) ub(E)_n^(-1) dots.c ub(E)_2^(-1) ub(E)_1^(-1)
=> ub(R) = ub(E)_n^(-1) dots.c ub(E)_2^(-1) ub(E)_1^(-1)$:
$
ub(Q)_0 &= mat(1, 1, 1; 0, 1, 1; 0, 1, 0) quad
ub(Q)_1 = ub(Q)_0 ub(E)_1
= mat(1, 1, 1; 0, 1, 1; 0, 1, 0) mat(1, -1 / sqrt(2), 0; 0, 1 / sqrt(2), 0; 0, 0, 1) = mat(1, 0, 1; 0, 1 / sqrt(2), 1; 0, 1 / sqrt(2), 0)\
ub(Q)_2 &= ub(Q)_1 ub(E)_2
= mat(1, 0, 1; 0, 1 / sqrt(2), 1; 0, 1 / sqrt(2), 0)
mat(1, 0, -sqrt(2); 0, 1, -1; 0, 0, sqrt(2))
= mat(1, 0, 0; 0, 1 / sqrt(2), 1 / sqrt(2); 0, 1 / sqrt(2), -1 / sqrt(2))
$

1. $ub(E)_1$: $bold(v)_2$ times $1 \/ sqrt(2)$,
  then subtract $1 \/ sqrt(2) bold(v)_1$ from $1 \/ sqrt(2) bold(v)_2$
2. $ub(E)_2$: $bold(v)_3$ times $sqrt(2)$,
  then subtract $sqrt(2) bold(v)_1$ from $sqrt(2) bold(v)_3$,
  subtract $bold(v)_2$ from $sqrt(2) bold(v)_3$

== Householder reflections

*Householder transformation* of $bold(v) in RR^n$:
$
ub(H)_(bold(v))
= ub(I)_(n times n) - 2 (bold(v) bold(v)^trans) / (bold(v)^trans bold(v))
= ub(I)_(n times n) - 2 (bold(v) bold(v)^trans) / norm(bold(v))_2^2.
$
- For $(bold(v), bold(v)) = 1$, $ub(H) = ub(I) - 2 bold(v) bold(v)^trans$,
- $bold(x), bold(y)$ with $norm(bold(x))_2 = norm(bold(y))_2$,
  we can construct $bold(v) = bold(y - x) / norm(bold(y - x))_2$, 
  such that $ub(H) bold(x) = bold(y)$.

// #pseudocode-list(
//   booktabs: true,
//   title: [
//     Householder-QR($ub(A)$)
//     - Factors $ub(A) in RR^(m times n)$ as $ub(A) = ub(Q) ub(R)$
//     - $ub(Q) in RR^(m times m)$ is orthogonal and $R in RR^(m times n)$ is upper triangular
//   ])[
//   + $ub(Q) := ub(I)_(m times m)$, $ub(R) := ub(A)$
//   + *for* $k := 1 .. m$
//     + $bold(a) := ub(R) bold(e)_k$
//       Isolate column $k$ of $ub(R)$ and store it in $bold(a)$
//     + $(bold(a)_1, bold(a)_2) := "split"(bold(a), k - 1)$
//       Separate off the first $k - 1$ elements of $bold(a)$
//     + $c := norm(bold(a)_2)_2$
//       Find reflection vector $bold(v)$ for the Householder matrix $ub(H)_(bold(v))$
//       - If you use a more stable way, $c := -"sgn"(bold(a)_(2 1)) norm(bold(a)_2)_2$
//     + $bold(v) := vec(bold(0), bold(a)_2) - c bold(e)_k$
//     + $ub(R) := ub(H)_(bold(v)) ub(R)$
//       Eliminate elements below the diagonal of the $k$-th column
//     + $ub(Q) := ub(Q) ub(H)_(bold(v))^trans$
//   + *return* $ub(Q), ub(R)$
// ]
_Example_: Find QR decomposition of $ub(A) = mat(2, -2, 18; 2, 1, 0; 1, 2, 0)$.\
First, $bold(a)_1 = mat(2; 2; 1),
bold(v)_1 = bold(a)_1 + "sgn"(a_(1 1)) norm(bold(a)_1)_2 bold(e)_1
= mat(2;2;1) + sqrt(sum_(k=1)^m a_(1k)^2) mat(1;0;0)$,\
$ub(H)_1 = ub(I) - 2 (bold(v)_1^trans bold(v)_1) / norm(bold(v)_1)_2^2,
ub(H)_1 ub(A) = 
mat(-3, 0, -12; 0, 1.8, -12; 0, 2.4, -6)$.\
Next, submatrix $ub(A)^((1)) = mat(1.8, -12; 2.4, -6), 
bold(hat(v))_2 = mat(1.8;2.4) + sqrt(sum_(j=1)^m a_(2k)^2) mat(1;0) = mat(4.8; 2.4)$,\
$ub(hat(H))_2 = ub(I) - 2 (bold(hat(v))_2^trans bold(hat(v))_2) / norm(bold(hat(v))_2)_2^2,
ub(H)_2 = mat(1, ub(0)_(1 times 2); ub(0)_(2 times 1), ub(hat(H))_2),
ub(H)_2 ub(H)_1 ub(A) = mat(-3, 0, -12; 0, -3, 12; 0, 0, 6).$\
Similarly find $ub(H)_3$. Then $ub(Q) = ub(H)_1 ub(H)_2 ub(H)_3$, $ub(R) = ub(H)_3 ub(H)_2 ub(H)_1 ub(A)$.
- NOTE: this course textbook uses $bold(v) = bold(a) - norm(bold(a))_2 bold(e)$, no sign function $"sgn"(a_(1 1))$

