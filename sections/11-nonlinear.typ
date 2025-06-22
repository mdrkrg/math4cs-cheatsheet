= Non-linear systems
- Lipschitz continuity:
  $norm(f(bold(x)) - f(bold(y))) <= c norm(bold(x) - bold(y))_2$
  for all $bold(x), bold(y)$.
- Intermediate value theorem: $f : [a, b] -> RR$ continuous,
  $f(a) < u < f(b)$ or $f(b) < u < f(a)$. Then $exists z in (a, b)$ such that $f(z) = u$.

== Bisection method

```py
def bisect(f, a, b, tolerance):
  assert(f(a) * f(b) < 0)
  while abs(a - b) / 2.0 > tolerance:
    x_new = float(a + b) / 2.0
    if (f(a) * f(x_new) < 0): b = x_new
    else: a = x_new
  return float(a + b) / 2.0
```

== Fixed point iteration $x_(k+1) = g(x_k)$, $E_k = abs(x_k - x^star) = |g(x_(k-1)) - g(x^star)|$
- When $g$ is Lipschitz, converges:
  $E_k <= c abs(x_(k-1) - x^star) = c E_(k-1)$.
- When $g$ differentiable with $g'(x^star) = 0$, *quadratic convergence*:
  $E_k = 1 / 2 abs(g''(x^star)) Delta x_(k-1)^2 + O(Delta x_(k-1)^3)
<= 1 / 2 (abs(g''(x^star)) + epsilon) Delta x_(k-1)^2 \
= 1 / 2 (abs(g''(x^star)) + epsilon) E_(k-1)^2,
Delta x_(k-1) = x_(k-1) - x^star.
$

== Newton's method

Let $x^* in [a, b]$ to be an approximation to $x$. Use the first Taylor polynomial
$f(x) = f(x^*) + (x - x^*) f'(x^*) + (x - x^*)^2 / 2 f''(xi(x))$, where $xi(x)$ between $x, x^*$.
Since $f(x) = 0$, we can derive Newton's method as
#grid(columns: (1fr, 1.5fr), inset: 2pt)[
$
0 approx f(x^*) + (x - x^*) f'(x^*) \
=> x approx x^* - (f(x^*)) / (f'(x^*)).
$
Iterative form:
$ x_(i+1) = x_i - (f(x_i)) / (f'(x_i)). $

Error (quadratic):
$ lim_(i -> infinity) e_(i+1) / e_i^2 = M = abs((f''(x^*)) / (2 f'(x^*))). $

// If $f(x)$ is $(m + 1)$-times continuously differentiable on $[a, b]$,
// which contains a root $x^*$ of multiplicity $m > 0$ ($m$ 重根), then *modified Newton's method*:
// $x_(i+1) = x_i - (m f(x_i)) / (f'(x_i))$.
][
```py
def newton(f, df, x0, tol):
  cur_tol = float("inf")
  x1 = x0
  while cur_tol > tol:
    x1 = x0 - f(x0) / df(x0)
    cur_tol = abs(x0 - x1)
    x0 = x1
  return x1
```
]
== Sceant method 割线法

Replaces the tangent line ($diff f$) with the secant line.\
$
f'(x_i) approx (f(x_i) - f(x_(i-1))) / (x_i - x_(i-1))
=>
x_(i+1) = x_i - (f(x_i)(x_i - x_(i-1))) / (f(x_i) - f(x_(i-1))).
$
Error terms:
$e_(i+1) approx abs((f''(x^*)) / (2f'(x^*))) e_i e_(i-1)
= abs((f''(x^*)) / (2f'(x^*)))^(alpha - 1) e_i^alpha, "where" alpha = (1 + sqrt(5)) / 2$.
// ```py
// def secant(f, x0, x1, tol=1e-3):
//   cur_tol = tol + 1.0
//   x2 = (f(x0) - f(x1)) / (x0 - x1)
//   while cur_tol > tol:
//     df = (f(x0) - f(x1)) / (x0 - x1)
//     x2 = x1 - f(x1) / df
//     cur_tol = abs(x0 - x1)
//     x0 = x1
//     x1 = x2
//   return x2
// ```
