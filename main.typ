#import "./utils.typ": *

#set document(
  author: "Midori Kurage <tonygong233@gmail.com>",
  title: "SE2324 Mathematical Foundation in Computer Science Final 2025",
  date: datetime(year: 2025, month: 6, day: 18),
)

#show: knowledge-key.with(
  title: context [#document.title],
  authors: [Midori Kurage / CC BY-NC-SA 4.0 #cc-by-nc-sa],
)
#show: codly-init.with()

#set text(font: (
  "Libertinus Serif",
  "Noto Serif CJK SC",
))

#include "sections/01-prob.typ"
#include "sections/02-info.typ"
#include "sections/03-mdp.typ"
#include "sections/04-opt.typ"
#include "sections/05-err.typ"
#colbreak()
#include "sections/06-lu.typ"
#include "sections/07-linear.typ"
#include "sections/08-qr.typ"
#include "sections/09-eigen.typ"
#include "sections/10-svd.typ"
#include "sections/11-nonlinear.typ"
