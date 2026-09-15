#!/bin/zsh
# Build DesktopFly
set -e
cd "$(dirname "$0")"
swiftc -target "$(uname -m)-apple-macos13.0" -module-cache-path "${TMPDIR:-/tmp}/desktopfly-module-cache" -O -swift-version 5 -o DesktopFly main.swift FlyModel.swift LegDynamics.swift Locomotor.swift LocomotorTests.swift BeetleModel.swift Sim.swift BrainView.swift \
    Environment.swift PetCare.swift PetPanel.swift Family.swift ZoteroResearch.swift -framework Cocoa -framework SceneKit
echo "Built ./DesktopFly"
