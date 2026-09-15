// Accelerated desktop life cycle. No claim of neural courtship or genetic simulation.
import Foundation

struct FlyFamily {
    enum Stage: String { case alone = "独居", paired = "两只作伴", courting = "求偶", egg = "卵", larva = "幼虫", pupa = "蛹", adult = "新成虫" }
    private(set) var stage: Stage = .alone
    private(set) var elapsed = 0.0
    var hasPartner: Bool { stage != .alone }
    var hasChild: Bool { stage == .adult }
    var canBreed: Bool { stage == .paired }
    var duration: Double {
        switch stage {
        case .courting: return 15
        case .egg: return 30
        case .larva: return 45
        case .pupa: return 45
        default: return 0
        }
    }
    mutating func addPartner() -> Bool {
        guard stage == .alone else { return false }
        stage = .paired; return true
    }
    mutating func breed() {
        guard canBreed else { return }
        stage = .courting; elapsed = 0
    }
    mutating func advance(_ dt: Double) {
        guard dt.isFinite, dt > 0, duration > 0 else { return }
        elapsed += dt
        while duration > 0 && elapsed >= duration {
            elapsed -= duration
            switch stage {
            case .courting: stage = .egg
            case .egg: stage = .larva
            case .larva: stage = .pupa
            case .pupa: stage = .adult; elapsed = 0
            default: return
            }
        }
    }
    var summary: String {
        let timer = duration > 0 ? " · 还需 \(Int(ceil(duration - elapsed))) 秒" : ""
        return "家庭：\(stage.rawValue)\(timer)"
    }
}

func runFamilyTests() {
    func check(_ condition: Bool, _ label: String) {
        guard condition else { fputs("FAIL: \(label)\n", stderr); exit(1) }
        print("PASS: \(label)")
    }
    var f = FlyFamily(); f.breed()
    check(f.stage == .alone, "a partner is required")
    check(f.addPartner() && !f.addPartner(), "only one partner can be added")
    f.breed(); f.advance(15)
    check(f.stage == .egg, "courtship precedes egg")
    f.breed(); f.advance(30)
    check(f.stage == .larva, "duplicate breed requests do not reset development")
    f.advance(45); check(f.stage == .pupa, "larva becomes pupa")
    f.advance(45); check(f.hasChild, "pupa produces an adult")
    f.breed(); f.advance(1000)
    check(f.hasChild && !f.canBreed && !f.addPartner(), "one brood per session; three-adult cap")
    var b = FlyFamily(); _ = b.addPartner(); b.breed(); b.advance(135)
    check(b.stage == f.stage, "large and small time steps produce the same stage")
    print("ALL FAMILY TESTS PASS")
}
