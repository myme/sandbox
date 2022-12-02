#!/usr/bin/env python3
#
# Shuffle an input list into pairs of assignments where the pairs are random and
# none should be isomorphic (except if the list length is either 1 or 2, where
# it's unavoidable).
#
# See:
#  - https://twitter.com/ubermyme/status/1466409391767310340
#  - https://mastodon.social/@myme/109444401715629325

from operator import itemgetter
import random

inputs = list({
    'Ole',
    'Dole',
    'Doffen',
    'Donald',
    'Skrue',
})

random.shuffle(inputs)

assigned = zip(inputs, inputs[1:] + inputs[0:1])
for src, dst in sorted(assigned, key=itemgetter(0)):
    print(f'{src} → {dst}')
