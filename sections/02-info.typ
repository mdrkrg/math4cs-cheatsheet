#import "../utils.typ": *

= Information theory

== Concept of information entropy 信息熵

Information entropy measures the *average amount of uncertainty* or "surprise" inherent in a random variable's possible outcomes.
- High Entropy: Indicates a lot of uncertainty. The outcomes are more unpredictable, and when an outcome does occur, it conveys more "information" because it resolves a greater degree of uncertainty.
- Low Entropy: Indicates less uncertainty. Some outcomes are much more likely than others. The result is more predictable.

== Calculation of entropy

Let $X$ be be a random variable taking on a finite number of different values $X in {x_1, ..., x_M}$ with probabilities $(p_1, ..., p_M)$. The Entropy is defined as the expected (average) information over the distribution of a random variable.
$
H(X)
= bb(E){log 1 / (p(X))}
= - sum_(x in X) p(x) log_2 p(x) "bits"
$
- When $p(x)$ is a uniform distribution, $H(X)$ is maximized.
- When $p(X) = 1$ for one $x$, $H(X) = 0$.

Joint Entropy: the *total uncertainty* associated with the pair of random variables.
$
H(X, Y)
= - sum_(x in X) sum_(y in Y) p(x, y) log_2 p(x, y)
$
Conditional Entropy: the *remaining uncertainty* about Y when X outcome is known. If knowing X makes Y predictable, $H(Y|X)$ is small. If X gives no clue about Y, $H(Y|X) = H(Y)$.
$
H(Y | X)
= - sum_(x in X) sum_(y in Y) p(x, y) log_2 p(y | x)
$
Chain rule for Entropy
$
H(X,Y) = H(X) + H(Y | X) = H(Y) + H(X | Y)
$
Cross Entropy: measures the average number of bits needed to identify an event drawn from a true distribution $p$, if we use an encoding scheme optimized for an assumed (and possibly incorrect) distribution $q$.
$
"CE"(p, q) = EE_(x ~ p(x)) {log_2 1 / q(x)} = - sum_(x in X) p(x) log_2 q(x)
$
Relative Entropy (KL divergence): measures the "extra bits" needed on average to encode events from a true distribution $p$ when using a code optimized for an assumed distribution $q$, compared to that for the true distribution $p$ itself. "Distance" between two distributions.
$
D_"KL" (p || q) = sum_(x in X) p(x) log_2 p(x) / q(x) >= 0
$
- $"KL" = 0 <=> p=q$
- $D_"KL" (p || q) = "CE"(p, q) - H(p)$
Mutual Information: the amount of information that one random variable carries about another one.
$
I(X; Y)
= sum_(x in X) sum_(y in Y) p(x, y) log_2 p(x, y) / (p(x)p(y))
= D_"KL" (p(x, y) || p(x)p(y))
$
- Quantifies the *reduction in uncertainty* about X that results from knowing Y.
- Symmetric: $I(X; Y) = I(Y; X)$.
- If X and Y are independent, $I(X; Y) = 0$.

#cetz.canvas({
import cetz.draw: *

venn2(name: "venn", ab-fill: gray.lighten(30%), b-fill: gray)
content("venn.a", $H(X | Y)$)
content("venn.b", $H(Y | X)$)
content("venn.ab", $I(X;Y)$)
content((-0.7, -1.1), $H(X)$)
content((0.7, -1.1), $H(Y)$)
content((0.0, 1.0), $H(X, Y)$)
})

== Decision tree

A tree-like model of decisions with possible consequences. A supervised learning method used for *classification* (predicting a categorical label, like `+` or `-`) and *regression* (predicting a continuous value).
- *Root Node:* the entire dataset or the starting of the decision process.
- *Internal Nodes (Decision Nodes):* a "test" on an attribute (e.g., "Is Attribute A = 1?"). Each internal node has branches corresponding to the possible outcomes of the test.
- *Branches:* the outcome of a test (e.g., for an attribute `A`, branches could be `A=0` and `A=1`). Each branch leads to another node.
- *Leaf Nodes:* result, a class label (the decision or prediction).

How to construct decision tree: minimize entropy of class Y when selecting each attribute X. \
How to select attribute: select $X$ having the maximum *information gain*:
$
"IG"(Y, X) = H(Y) - H(Y | X).
$

=== Example: information gain on a split
- Root attribute `(1: 100, 0: 49)`,
  left `(1: 50, 0: 0)`,
  right `(1: 50, 0: 49)`
- Root entropy: 
  $H(Y) = - 49 / 149 log_2(49 / 149) - 100 / 149 log_2 (100 / 149) approx 0.91$
- Leaves entropy: $H(Y | "left") = 0, H(Y | "right") approx 1$
- $"IG"("split") approx 0.91 - (1 / 3 dot.c 0 + 2 / 3 dot.c 1)$

=== Example: selecting the next split

Build a decision tree to classify them according to Y.

#grid(columns: 2, inset: 2pt)[
#table(
columns: 3,
inset: 2pt,
[Y], [A], [B],
[-], [1], [0],
[-], [1], [0],
[+], [1], [0],
[+], [1], [0],
[+], [1], [1],
[+], [1], [1],
[+], [1], [1],
[+], [1], [1],
)
][
#let calc_entropy = (arr) => {
  let sum = arr.sum()
  return arr.fold(0, (accu, item) => 
    accu - item / sum * calc.log(item / sum, base: 2))
}

#let hy = calc_entropy((2, 6))
$H(Y) = #hy, \
H(Y|A) = #hy, \
P(Y=1 | B=1) = 1, P(Y=1, B=1) = 0.5, \
P(Y=0 | B=1) = 0, P(Y=0, B=1) = 0, \
P(Y=1 | B=0) = 0.5, P(Y=1, B=0) = 0.25, \
P(Y=0 | B=0) = 0.5, P(Y=0, B=0) = 0.25. \
#let hy-on-b = -0.5 * calc.log(1, base:2) - 0.25 * calc.log(0.5, base:2) * 2
therefore H(Y|B) = #hy-on-b. \
I(Y;A) = 0, I(Y;B) = #{hy - hy-on-b}, I(Y; A) < I(Y; B).
$

Therefore, we should take attribute B.
]

