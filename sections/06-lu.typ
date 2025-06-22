#import "../utils.typ": *

= Linear systems

== Solvability of $ub(A) bold(x) = bold(b), ub(A) in RR^(m times n)$

- Unique solution:
  $ub(A)$ square invertible,
  or $m > n$, $"rank"(ub(A)) = n$, $bold(b) in "Col"(ub(A))$
- Infinite:
  $ub(A)$ square, singular (not invertible), $bold(b) in "Col"(ub(A))$,
  or $m < n$, $"rank"(ub(A)) = m$,
  or $ub(A)$ not full rank, $bold(b) in "Col"(ub(A))$
- No solution: $b in.not "Col"(ub(A))$

== Gaussian elimination

- Swap one equation for another.
- Add or subtract a multiple of one equation from another.
- Multiply an equation by a non-zero constant.

== LU decomposition: $ub(A) = ub(L)ub(U)$, $ub(L)$ lower triangular, $ub(U)$ upper triangular
The Gaussian elimination process can be written as
$
ub(L)_n dots.c ub(L)_1 ub(A) = ub(U)
=> ub(A) = ub(L)_1^(-1) dots.c ub(L)_n^(-1) ub(U) = ub(L)ub(U)
$
where $ub(L)_j$ is a step of of Gaussian elimination: $ub(L)_j = ub(I) + mu_(r s) ub(E)^((r s))$.\
_Example_:
1. Adding row 1 to row 2 and $2 times$ row 1 to row 3,\
   $ub(L_1) = mat(1,,;,1;2,,1) times mat(1,,;1,1,;,,1) 
   = (ub(I) + 2ub(E)^((31))) times (ub(I) + ub(E)^((21)))$.
2. Subtracting row 2 from row 3, result gives $ub(U)$,\
   $ub(L_2) = mat(1,,;,1,;,-1,1)
   = ub(I) - ub(E)^((32))$.
3. $ub(L) = ub(L_1)^(-1) ub(L_2)^(-1), ub(A) = ub(L) ub(U)$.

If Gaussian elimination can be performed on $ub(A) bold(x) = bold(b)$
*without row interchanges*, this LU decomposition (unique) can be applied.

LU decomposition solution to linear system
$ub(A) bold(x) = ub(L U) bold(x) = bold(b)$: Let $bold(c) = ub(U) bold(x)$
+ Solve $ub(L) bold(y) = bold(b)$ for $bold(c)$:
  $y_1 = b_1 / l_(11), y_i = 1 / l_(i i) [b_i - sum_(j=1)^(i-1) l_(i j) y_j]$.
+ Solve $ub(U) bold(x) = bold(y)$ for $bold(b)$:
  $x_n = y_n / u_(n n), x_i = 1 / u_(i i) [y_i - sum_(j = i + 1)^n u_(i j) x_j]$ (backward).
