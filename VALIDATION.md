# v0.1.0 validation

Local build: Apple Silicon (arm64), macOS 27.0, Swift 6.3.2, deployment target macOS 13.
Other operating-system versions and Intel hardware have not been tested.

Passed: `--caretest`, `--familytest`, `--simtest`, `--behaviortest`, `--locomotortest`.
These verify software behavior, not agreement with real fly physiology.

Native UI checks cover launch from an app bundle, successful feeding and satiety,
adding a partner, visible life-stage progression, rest/wake controls and pause.
The app is ad-hoc signed for local use and has not been Apple-notarized.

Known limits:
- No save/resume across app launches.
- One brood per run; at most three adult flies.
- Courtship is a timed lifecycle stage, not neural interaction between mates.
- Partner/offspring behavior is scripted; only the original fly has a neural simulation.
- Prolonged power/thermal behavior and multi-monitor changes are not QA-complete.
