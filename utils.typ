#import "@preview/knowledge-key:1.0.2": *
#import "@preview/codly:1.3.0": *
#import "@preview/ccicons:1.0.0": *
#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/tablex:0.0.9": tablex
#import "@preview/lovelace:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/cetz:0.3.2"
#import "@preview/cetz-venn:0.1.3": venn2
#import "@preview/diagraph:0.3.2"

#let ub(x) = $upright(bold(#x))$
#let trans = $upright(T)$

#let over(x, t: sym.macron) = $limits(attach(limits(#x), t: #t), inline: #false)$
