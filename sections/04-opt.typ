#import "../utils.typ": *

= Optimization theory

Search for best solution: minimization or maximization of an objective function $f(x)$ depending on variables $x$ subject to constraints:
$
min f(x) "s.t."
& g_i (x) <= 0 "for" i = 1, ..., m, & ("Inequality constraints")\
& h_j (x) = 0 "for" j = 1, ..., p, & ("Equality constraints")\
& x in chi. & ("Domain of" x)
$

Convertion: 

- Maximizing $f(x)$ $<=>$ minimizing $-f(x)$
- $g(x) >= 0 <=> -g(x) <= 0$
- $g(x) = 0 <=> g(x) <= 0 "and" -g(x) <= 0$ (two inequalities)

== Recap: linear algebra

=== Vector norms 范数

- $p$-norm $(p >= 1)$
  $norm(bold(x))_p = (abs(x_1)^p + abs(x_2)^p + dots.c + abs(x_n)^p)^(1/p)$.
- $infinity$-norm $norm(bold(x))_infinity = max(abs(x_1), abs(x_2), dots.c, abs(x_n))$

=== Induced matrix norm: matrix norm on $RR^(m times n)$ induced by vector $norm(dot.c)$

The matrix norm *induced* by a vector norm $norm(dot.c)$:
$norm(ub(A)) equiv max{norm(ub(A) bold(x)) : norm(bold(x)) = 1}$.
- $norm(ub(A))_1 = max_(1 <= j <= n) sum_(i=1)^m abs(a_(i j))$, maximum absolute column sum.
- $norm(ub(A))_infinity = max_(1 <= i <= m) sum_(j=1)^n abs(a_(i j))$, maximum absolute row sum.
- $ub(A) in RR^(n times n)$,
  $norm(ub(A))_2^2
  = max{lambda : "there exists" bold(x) in RR^n "with" ub(A)^trans ub(A) bold(x) = lambda bold(x)}$, (square root of) the largest eigenvalue of $ub(A)^trans ub(A)$ (_spectral norm_).

=== Positive (semi-)definite (PSD) matrices

If $forall bold(x) in RR^n, bold(x)^trans ub(A) bold(x) >= 0$, then $ub(A) >= 0$ is PSD. If $> 0$, then $ub(A) > 0$ is PD.

- Symmetric
- All eigenvalues are non-negative

== Canonical form of linear programming (LP)

$
"maximize" bold(c)^trans bold(x), "subject to" & bold(a)_i^trans bold(x) <= b_i, "for" i = 1, ..., m, \
& x_j >= 0, "for" j = 1, ..., n.
$

- Minimizing $bold(c)^trans bold(x)$ $<=>$ maximizing $-bold(c)^trans bold(x)$,
- $>=$ constraints can be flipped by $times -1$,
- Each equality constraint $<=>$ two inequalities ($bold(a)_i^trans bold(x) <= b_i$ and $-bold(a)_i^trans bold(x) <= -b_i$),
- Unconstrained variables $x_j$ can be replaced by $x_j^+ - x_j^-$, where $x_j^+ >= 0$ and $x_j^- >= 0$.

== Types of optimization problems


Each is included by its successor
- LP Linear programming
- QP Quadratic programming 二次规划
  - Minimize a convex quadratic function 凸二次函数 over a polyhedron
  - $
    min bold(x)^trans ub(P) bold(x) + bold(c)^trans bold(x) + bold(d) "s.t." ub(A) bold(x) <= bold(b)
    $
  - Require $ub(P) >= 0$ (PSD), convex optimization (any local minimum found is also a global minimum)
- QCQP Quadratically constrained 二次约束 quadratic programming
  - Minimize a convex quadratic function over a quadratic constraint
  // - $
  //   min & 1/2 bold(x)^trans ub(P)_0 bold(x) + bold(q)_0^trans bold(x) + bold(r)_0 \
  //   "s.t." &
  //   1/2 bold(x)^trans ub(P)_i bold(x) + bold(q)_i^trans bold(x) + bold(r)_i <= 0,
  //   i = 1, ..., m, \
  //          & ub(A) bold(x) = bold(b)
  //   $
  - $
    min & 1/2 bold(x)^trans ub(P)_0 bold(x) + bold(q)_0^trans bold(x) + bold(r)_0
    "s.t."
    1/2 bold(x)^trans ub(P)_i bold(x) + bold(q)_i^trans bold(x) + bold(r)_i <= 0,
    i = 1, ..., m,
    ub(A) bold(x) = bold(b)
    $
  - All $ub(P)$ matrices associated with functions that need to be convex (objective for $min g_i "for" g_i <= 0$) must be PSD
- GP Geometric programming
  - $
    min    & f_0 (x) \
    "s.t." & f_i (x) <= b_i "for" i in CC_1, &"Posynomial inequality constraints" \
           & h_j (x) = b_j "for" j in CC_2,  &"Monomial equality constraints" \
           & x >= 0.
    $
    where $f_i$ is posynomial, $h_i$ is monomial, and $b_i > 0$.
  - Converting to convex form: $f(x) = c x_1^(a_1) dots.c x_n^(a_n)$ is a monomial, then $log f(e^y) = log c + a_1 y_1 + dots.c + a_n y_n$, which is affine in y, is convex

=== Monomial 单项式 and posynomials 正多项式

- A monomial is a function $f: RR^n_+ -> RR_+$ of the form
  $f(x) = c x_1^(a_1) x_2^(a_2) dots.c x_n^(a_n)$,
  where $c >= 0, a_i in RR$.
- A posynomial is a sum of monomials.

== Solving optimization problems

=== Unconstrained minimization (direct solution)
$f(x)$ convex, twice continuously differentiable
- One dimensional: the *flat* point where $f'(x) = 0$ is the minimum
- Multi-dimensional: gradient $gradient_x f(x) = vec((partial f) / (partial x_1) (x), ..., (partial f) / (partial x_n) (x), delim: "[")$,
  find $gradient_x f(x^star) = bold(0)$

=== Iterative methods

$gradient_x f(x^star) = 0$ may not have an analytical solution,
use sequence of points $x^((k)) in "dom" f, k = 0, 1, ...$
with $f(x^((k))) -> "OPT"("primal")$.

==== Gradient descend

Gradient points to the direction of *steepest ascent* for the function
- Goal: $min_x f(x)$
- Iteration: $x^((t+1)) = x^((t)) - eta_t gradient_x f(x^((t)))$, take step to negative $gradient$ (step size $eta_t$)

==== Newton's method: second order approximation of $f$

Iteration: $x^((t+1)) = x^((t)) - [gradient_x^2 f(x^((t)))]^(-1) gradient_x f(x^((t)))$, uses the *Hessian matrix* at $x^((t))$:
$gradient_x^2 f(x) = ub(H) f(x) = mat((partial^2 f) / (partial x_1^2), dots.c, (partial^2 f) / (partial x_1 x_n);
     dots.v, dots.down, dots.v;
     (partial^2 f) / (partial x_n partial x_1), dots.c, (partial^2 f) / (partial x_n^2))
  $

=== Constrained minimization
$
min f_0 (x) "s.t." f_i (x) <= 0, i = 1, ..., m, ub(A) bold(x) = bold(b)
$
- $m$ inequality constrains $f_i (x) <= 0, i = 1, ..., m$,
- Made implicit by rewriting the objective with *penalty function*:
  $min f_0 (x) + sum_(i=1)^m I_- (f_i (x)) "s.t." ub(A) bold(x) = bold(b)$,
  where $I_- (u) = cases(0 & u <= 0\,, infinity & "otherwise".)$
  penalizing infeasible solution to be chosen as minimum
- Approximate $I_-$ with *logarithmic barrier function*
  $I_- (u) = - mu log(-u)$, $"dom" I_- = {x in RR | x < 0}$, where *barrier parameter* $mu > 0$ 
  - When $mu$ is large, the barrier is softer
  - As $mu -> 0^+$, the barrier better approximates the original penalty function

==== Logarithmic barrier function 对数闸函数 (differentiable)

Approximation of the penalty function:
$
min f_0 (x) + mu phi (x) "s.t." ub(A) bold(x) = bold(b),
$
with $phi(x) = - sum_(i=1)^m log(-f_i (x)),
"dom" phi = {x | f_1 (x) < 0, ..., f_m (x) < 0}$

==== Barrier method (path finding, interior point method)

- Interior point method: variables are always within the feasible set
- Start with a large $mu$,
  iteratively reduce $mu$ until a desired solution accuracy.

*given* an initial feasible point $x, mu$, tolerance $epsilon.alt > 0$, reduction factor $0 < beta < 1$, *repeat*
  1. Centering step. Starting at $x$, use Newton's method to solve
    $x^star (mu) = min_x mu f_0 (x) + phi(x) "s.t." ub(A) bold(x) = bold(b)$,
  2. Update. $x := x^star (mu)$,
  3. Stopping criterion. *quit* if $m mu < epsilon.alt$.
  4. Target shifting. $mu := beta mu$.
