# Upstream and changes

Tangdou is a macOS companion fork of [DenisSergeevitch/desktop-fly](https://github.com/DenisSergeevitch/desktop-fly).
Starting commit: `32b00011e83c3dc85fa3ea0b3934155b04f1635d`.

Denis Shiryaev and upstream contributors authored the neural simulation, body,
locomotion, brain viewer, desktop sensing, source-data extraction, and their tests.
Their MIT copyright notice and separate dataset notices are preserved unchanged.
See `UPSTREAM_README.md`, `data/DATA_LICENSE.md` and `data/LOCOMOTOR_PROVENANCE.md`.

Tangdou adds a Chinese care panel, hand-feeding, a bounded satiety meter,
manual resting, a locate marker, a bounded accelerated family lifecycle,
macOS app packaging and care/lifecycle tests. New source contributions are
provided under the same MIT code license. Existing Windows code is retained
as upstream material; Tangdou's new features have only been implemented on macOS.

The primary fly uses the upstream 668-neuron FlyWire and 1,045-neuron MaleCNS
circuit models. The brain display contains 23,210 soma positions; that is not
the number of simulated neurons. Added partner/child flies use upstream scripted
body behavior, not independent neural simulations. The combined source specimens
and rendered bodies are not an individual male/female physiological model.

Food and family progression are explicitly engineered pet mechanics. Satiety
is not a biological metabolic measurement; courtship is a timed game stage,
not demonstrated neural mate selection. There are no gametes, genetics,
heritable learning, pain model or claims of validated reproductive behavior.
