import Cocoa

final class PetPanel {
    let panel: NSPanel
    private let status = NSTextField(wrappingLabelWithString: "正在醒来…")
    private let feed: NSButton
    private let rest: NSButton
    private let pause: NSButton
    private let partner: NSButton
    private let breed: NSButton
    private let sync: NSButton
    private let read: NSButton

    init(target: AppDelegate) {
        panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 340, height: 540),
                        styleMask: [.titled, .closable, .utilityWindow], backing: .buffered, defer: false)
        panel.title = "糖豆 Tangdou"
        panel.appearance = NSAppearance(named: .aqua)
        panel.isReleasedWhenClosed = false
        panel.hidesOnDeactivate = false
        panel.level = .floating
        panel.backgroundColor = NSColor(calibratedRed: 0.98, green: 0.97, blue: 0.94, alpha: 1)
        func button(_ title: String, _ action: Selector) -> NSButton {
            let b = NSButton(title: title, target: target, action: action)
            b.bezelStyle = .rounded; b.controlSize = .large
            return b
        }
        partner = button("💕 找个伴侣", #selector(AppDelegate.addPartner))
        breed = button("🥚 模拟繁育", #selector(AppDelegate.breedFamily))
        sync = button("📚 同步 Zotero", #selector(AppDelegate.syncZotero))
        read = button("📖 读下一篇", #selector(AppDelegate.readNextPaper))
        feed = button("🍬 喂一滴糖水", #selector(AppDelegate.feedPet))
        rest = button("🌙 休息一下", #selector(AppDelegate.restPet))
        pause = button("暂停", #selector(AppDelegate.pausePet))
        let title = NSTextField(labelWithString: "🪰  你好，我是糖豆")
        title.font = .systemFont(ofSize: 22, weight: .semibold)
        title.textColor = NSColor(calibratedWhite: 0.15, alpha: 1)
        status.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        status.textColor = NSColor(calibratedWhite: 0.25, alpha: 1)
        let note = NSTextField(wrappingLabelWithString: "在窗口边缘散步，累了就睡。\n靠近时轻一点，我可能会飞走。")
        note.font = .systemFont(ofSize: 13)
        note.textColor = NSColor(calibratedWhite: 0.35, alpha: 1)
        let foodNote = NSTextField(wrappingLabelWithString: "橙色圈是手喂糖水；停下后吃 5 秒。\n喂食是桌宠规则，神经活动可另行观察。")
        foodNote.font = .systemFont(ofSize: 11)
        foodNote.textColor = NSColor(calibratedWhite: 0.4, alpha: 1)
        let row = NSStackView(views: [feed, rest]); row.spacing = 8
        let row2 = NSStackView(views: [button("找到糖豆", #selector(AppDelegate.locatePet)), button("观察大脑", #selector(AppDelegate.toggleBrain))]); row2.spacing = 8
        let row3 = NSStackView(views: [pause, button("退出", #selector(AppDelegate.quitPet))]); row3.spacing = 8
        let familyRow = NSStackView(views: [partner, breed]); familyRow.spacing = 8
        let familyNote = NSTextField(wrappingLabelWithString: "加速生命周期：求偶 → 卵 → 幼虫 → 蛹 → 成虫\n约 2 分 15 秒一代，最多 3 只。伴侣与后代\n由行为规则驱动；这不是生殖神经模拟。")
        familyNote.font = .systemFont(ofSize: 11)
        familyNote.textColor = NSColor(calibratedWhite: 0.35, alpha: 1)
        let researchNote = NSTextField(wrappingLabelWithString: "科研成长：本地读取 Zotero 题录、摘要和 PDF 全文。\n不上传文献；成长积分来自阅读动作。")
        researchNote.font = .systemFont(ofSize: 11); researchNote.textColor = NSColor(calibratedWhite: 0.35, alpha: 1)
        let researchRow = NSStackView(views: [sync, read]); researchRow.spacing = 8
        let stack = NSStackView(views: [title, note, status, row, foodNote, familyRow, familyNote, researchRow, researchNote, row2, row3])
        stack.orientation = .vertical; stack.alignment = .leading; stack.spacing = 17
        stack.translatesAutoresizingMaskIntoConstraints = false
        panel.contentView!.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: panel.contentView!.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: panel.contentView!.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: panel.contentView!.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: panel.contentView!.bottomAnchor, constant: -20)
        ])
        if let screen = NSScreen.main {
            panel.setFrameTopLeftPoint(NSPoint(x: screen.visibleFrame.maxX - 370, y: screen.visibleFrame.maxY - 30))
        }
    }
    func show() { panel.makeKeyAndOrderFront(nil); NSApp.activate(ignoringOtherApps: true) }
    func update(summary: String, paused: Bool, resting: Bool, family: (partner: Bool, breed: Bool)) {
        status.stringValue = summary
        partner.isEnabled = !paused && family.partner
        breed.isEnabled = !paused && family.breed
        feed.isEnabled = !paused; rest.isEnabled = !paused
        rest.title = resting ? "☀️ 起床啦" : "🌙 休息一下"
        pause.title = paused ? "继续" : "暂停"
    }
    func showMessage(_ message: String) { status.stringValue = message; show() }
}
