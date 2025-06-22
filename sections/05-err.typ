#import "../utils.typ": *

= Error analysis

#grid(columns: 2)[
- Forward Error:
  measures the discrepancy between the computed
  (approximate) solution and the true (exact) solution.
  For a problem $y=f(x)$, if the computed result is $hat(y)$,
  the forward error is $norm(hat(y) - y)$ (absolute)
  or $norm(hat(y) - y) / norm(y)$ (relative). (Accuracy of output)
- Backward Error:
  quantifies the smallest perturbation
  to the input data required to make the computed solution exact.
  For $hat(y) = f(x)$, the backward error is the smallest $Delta x$
  such that $hat(y) = f(x + Delta x)$.
  (Stability of the algorithm and how "near" the original
  problem the computed solution lies)
- *Condition number*: $c = "F.E." \/ "B.E."$
][
#diagram(label-size: 6pt, spacing: 6pt, $
  & & f(x) \
	x
  edge("rru", "->", label: "Exact", label-angle: #auto)
  edge("rrdd", "-->", label: "Computed", label-angle: #auto) \
  edge("u", "<-->", label: "B.E.", label-side: #left)
  x + Delta x
  edge("rrb", "->", label: "Exact", label-angle: #auto, label-side: #right) \
  & & hat(y)
  edge("uuu", "<-->", label: "F.E.")
$)
]
