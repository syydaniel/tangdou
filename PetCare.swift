// Tangdou's explicitly engineered care layer, separate from neural physiology.
import Foundation

struct PetCare {
    static let mealDuration = 5.0
    private(set) var hunger = 0.45
    private(set) var foodRemaining = 0.0
    private(set) var resting = false
    private(set) var isEating = false
    private(set) var meals = 0
    private var waiting = 0.0
    var hasFood: Bool { foodRemaining > 0 }

    mutating func offerFood() {
        guard !hasFood else { return }
        resting = false
        foodRemaining = Self.mealDuration
        waiting = 0
    }
    mutating func setRest(_ value: Bool) {
        resting = value
        if value { foodRemaining = 0; isEating = false }
    }
    mutating func advance(dt: Double, grounded: Bool, threatened: Bool, asleep: Bool) {
        guard dt.isFinite, dt > 0 else { return }
        hunger = min(1, hunger + dt / 1800)
        isEating = hasFood && grounded && !threatened && !asleep && !resting
        guard hasFood else { return }
        if isEating {
            foodRemaining = max(0, foodRemaining - dt)
            if foodRemaining <= 1e-8 {
                foodRemaining = 0; hunger = max(0, hunger - 0.35); meals += 1
                isEating = false
            }
        } else {
            waiting += dt
            if waiting >= 30 { foodRemaining = 0 }
        }
    }
    func summary(state: String) -> String {
        let names = ["walking": "散步中", "idle": "发会儿呆", "grooming": "梳理自己", "flying": "飞行中", "sleeping": "睡觉中"]
        let action = isEating ? "正在吃糖水" : hasFood ? "等它停下来吃糖水" : names[state, default: "探索桌面"]
        return "\(action)\n饱腹 \(Int((1 - hunger) * 100))%  ·  本次已吃 \(meals) 滴"
    }
}

func runCareTests() {
    func check(_ condition: Bool, _ label: String) {
        guard condition else { fputs("FAIL: \(label)\n", stderr); exit(1) }
        print("PASS: \(label)")
    }
    var p = PetCare(); p.offerFood()
    for _ in 0..<60 { p.advance(dt: 1.0 / 60, grounded: false, threatened: false, asleep: false) }
    check(p.meals == 0 && p.foodRemaining == 5, "airborne pet cannot eat")
    p.advance(dt: 1, grounded: true, threatened: true, asleep: false)
    check(!p.isEating && p.meals == 0, "escape wins over food")
    for _ in 0..<300 { p.advance(dt: 1.0 / 60, grounded: true, threatened: false, asleep: false) }
    check(p.meals == 1 && !p.hasFood && p.hunger < 0.12, "completed meal gives one reward")
    p.offerFood(); p.advance(dt: 2, grounded: true, threatened: false, asleep: false)
    p.offerFood()
    check(abs(p.foodRemaining - 3) < 1e-6, "repeated clicks do not reset or stack a meal")
    p.setRest(true)
    check(!p.hasFood && !p.isEating && p.meals == 1, "rest cancels unfinished meal without credit")
    p.offerFood(); p.advance(dt: 30, grounded: false, threatened: false, asleep: false)
    check(!p.hasFood && p.meals == 1, "unreachable food expires")
    var a = PetCare(), b = PetCare(); a.offerFood(); b.offerFood()
    for _ in 0..<600 { a.advance(dt: 1.0 / 60, grounded: true, threatened: false, asleep: false) }
    for _ in 0..<1200 { b.advance(dt: 1.0 / 120, grounded: true, threatened: false, asleep: false) }
    check(a.meals == b.meals && abs(a.hunger - b.hunger) < 1e-6, "care is independent of display frame rate")
    print("ALL CARE TESTS PASS")
}
