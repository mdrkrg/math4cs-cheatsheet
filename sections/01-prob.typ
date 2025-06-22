#import "../utils.typ": *

= Probability

== Conditional Probability

$
P(X | Y) = (P(X, Y)) / (P(Y)) = (P(Y | X) P(X)) / (sum_i P(E | H_i) P(H_i))
$
Chain rule of probability:
- $n$ variables: $P(X_1, ..., X_n)
= P(X_1) P(X_2 | X_1) dots.c P(X_n | X_1, ..., X_(n-1))$

== Frequentist vs Bayesian: difference

- Frequentist: probabilities are long term relative frequencies.
- Bayesian: probabilities are logically consistent degrees of beliefs.
  - Applicable when experiments are not repeatable.
  - Depends on a person’s state of knowledge.

=== Bayesian rule

Concepts of Bayesian: with hypothesis $H$ and evidence $E$, we update our prediction of $H$ as $P(H | E)$ under the condition when a new $E$ occurs, based on how well new evidence $P(E | H)$ is explained.
- Prior probability 先验概率 $P(H)$: the probability of the hypothesis $H$ being true *before* you observe any evidence $E$.
- Posterior probability 后验概率 $P(H | E)$: the probability of the hypothesis $H$ being true, given that you *have observed* the evidence $E$.
- Likelihood 似然 $P(E | H)$: the probability of observing the evidence $E$, given that the hypothesis $H$ is true.
- Probability of evidence / Marginal likelihood 证据概率 / 边缘似然 $P(E)$: the overall probability of observing the evidence $H$.

$
P(H | E) = (P(H) P(E | H)) / P(E)
$

== Bayesian Network: compact way to represent joint distribution

Problem: complexity of *joint probability distributions*. $n$ binary variables mean $2^n - 1$ entries in a joint probability table.

Definition: A Bayesian Network, a graphical model that represents the probabilistic relationships among a set of random variables, includes:
1. A *DAG* $G = (V={X_1, ..., X_n}, E)$ (connection means influence)
  - Node: represents a *random variable* (e.g., Rain (discrete): `{True, False}`, Temperature (continuous))
  - Edges: $X -> Y$ represents $X$ (parent) has a *direct probabilistic influence* on $Y$ (child), $Y$ is conditionally dependent on $X$
  - Absence of an edge between two variables signifies a *conditional independence* relationship
2. A set of *conditional probability tables* $P(X_i | "Parents"(X_i))$ where
  *each $X_i$ denotes a data attribute.*
  - Lists the probability of $X_i$ taking on each of its possible values for every possible combination of values of its parent nodes
  - Root nodes are $P(X_i)$

*Joint probability factorization*

$
P(X_1, X_2, ..., X_n) = product_i P(X_i | "Parents"(X_i))
$

=== Example: "Wet Grass"

#grid(columns: 2)[
Variables
- `C` (Cloudy): {True, False}
- `S` (Sprinkler was on): {True, False}
- `R` (Raining): {True, False}
- `W` (Grass is wet): {True, False}
][
DAG Structure: #diagram(
	spacing: 0pt,
	node((1,0), `C`),
  edge("-|>"),
  edge((1,0), (2,1), "-|>"),
	node((0,1), `S`),
	node((2,1), `R`),
  edge("-|>"),
	node((1,3), `W`),
  edge((0,1), (1,3), "-|>"),
)
]

CPTs:
- `P(C)`: P(C=T) = 0.5
- `P(S|C)`: P(S=T|C=T)=0.1, P(S=T|C=F)=0.5
- `P(R|C)`: P(R=T|C=T)=0.8, P(R=T|C=F)=0.2
- `P(W|S,R)`: #table(
  columns: 3,
  inset: 2pt,
  table.header[S][R][$P(W=T | S, R)$],
  [ F ],[ F ],[ 0.0  ],
  [ F ],[ T ],[ 0.9  ],
  [ T ],[ F ],[ 0.9  ],
  [ T ],[ T ],[ 0.99 ],
)
Joint Probability Factorization:
$
P(C,S,R,W) = P(C) P(S, R|C) P(W|S, R) = P(C) P(S|C) P(R|C) P(W|S, R)
$

==== Inference

Example: "What is the probability it rained, given the grass is wet?" \
$P(R=T | W=T) = P(R=T,W=T) / P(W=T)$,
we need $P(W=T), P(W=T,R=T)$. \
To calculate $P(W,R)$, we need to marginalize $C$, $S$, we also make use of factorization (to use values in CPTs): \
$P(W,R) &= sum_s sum_c P(W,R,S=s,C=c) \
&= sum_s sum_c P(C=c) P(S=s|C=c) P(R|C=c) P(W|S=s, R).$
Same for $P(W) = sum_r sum_c sum_s P(W,R=r,S=s,C=c)$.

=== Markov Blanket 马尔可夫毯

For a target node X, its Markov Blanket, denoted MB(X), consists of:

- Parents of X: Nodes that directly point to X. These directly influence X.
- Children of X: Nodes that X directly points to. X directly influences them, so their state can provide information about X (e.g., through "explaining away").
- Other parents of X's children: Nodes that are also parents of X's children. If a child of X is observed, it can induce a dependency between X and the child's other parents (the collider effect).
