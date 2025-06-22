#import "../utils.typ": *

= Stochastic process

Formulated by a sequence of random variables $S_1, S_2, ..., S_T$, each represents the state of the system at a particular point in time.
$
PP[S_(t+1) | S_1, ..., S_t].
$

== Markov process: stochastic process with Markov property

*Markov property*: The future is independent of the past given the present.
$
PP[S_(t+1) | S_1, ..., S_t] = PP[S_(t+1) | S_t]
$

== State transition matrix: a matrix of transition probabilities

$p_(i j) = P[S_(t+1) = j | S_t = i] (P_(S_i -> S_j))$ is the probability of transition $S_i -> S_j$
- Each row: the current state $S_i$, elements represent all possible transitions from this state, $sum_(j=1)^n p_(i j) = 1, forall i = 1, ..., n$
- Each column: the target state to transit to $S_j$

=== Given a state $S_1$, what is the probability of $S_2$ $n$ jumps from now?
Let $ub(P)$ be the transition matrix, $S_1$ is on row $i$, $S_2$ is on row $j$, then $
P[S_(t+n) = j | S_t = i] = (ub(P)^n)_(i j).
$

=== Given a distribution of current state, what will the distribution be like $n$ jumps from now?

- Initial distribution of probabilities: $pi_0 = [pi_0(1), ..., pi_0(n)]$
- After $n$ jumps: $pi_n = pi_0 dot.c ub(P)^n$
- Stationary distribution 平稳分布: $pi_n = pi_n ub(P) = pi_(n+1) = pi_0 lim_(n -> infinity) ub(P)^n$

== Markov decision process 马尔可夫决策过程 $PP[S_(t+1) | S_t, A_t]$

Markov process with decision making and rewards $(S, A, {P_"sa"}, gamma, R)$
- $S$: a set of states
- $A$: a set of actions
- $\{P_"sa"\}$: probabilities of state transition
- $R$: $S times A -> R$ reward function
- $gamma in [0, 1]$: the discount of future rewards

Making best decisions: maximize long-term rewards.
- Discounted long-term return: $R_t = sum_(i =t)^infinity gamma^i r_i = r_t + gamma r_(t+1) + ...$
