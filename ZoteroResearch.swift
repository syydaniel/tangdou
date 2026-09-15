import Foundation

struct ZoteroPaper: Codable {
    let key: String
    let title: String
    let authors: String
    let abstractText: String
    let attachmentKey: String?
    let fullText: String?
}

struct ResearchProgress: Codable {
    var points = 0
    var papersRead = 0
    var abstractsRead = 0
    var notesWritten = 0
    var lastTitle = "还没有开始读文献"
    var level: Int { max(1, points / 100 + 1) }
    var title: String {
        switch level { case 1: return "实验室新生"; case 2: return "文献侦察员"; case 3: return "方法学助手"; default: return "研究伙伴 Lv.\(level)" }
    }
}

final class ZoteroResearchService {
    private let executable = "/Users/a1-6/.local/bin/zot"
    private let queue = DispatchQueue(label: "tangdou.zotero", qos: .utility)
    func fetchRecent(limit: Int = 8, completion: @escaping (Result<[ZoteroPaper], Error>) -> Void) {
        queue.async {
            do {
                let items = try self.run(["--local", "--library-id", "0", "--library-type", "user", "items", "list", "--top", "--limit", "\(limit)", "--sort", "dateModified", "--direction", "desc", "--output", "json"])
                let decoded = try JSONDecoder().decode([ZoteroItem].self, from: items)
                let papers = decoded.filter { ["journalArticle", "conferencePaper", "preprint", "book"].contains($0.data.itemType) }.map {
                    ZoteroPaper(key: $0.key, title: $0.data.title.isEmpty ? "无标题" : $0.data.title, authors: $0.data.creators.map { $0.name ?? [$0.firstName, $0.lastName].compactMap{$0}.joined(separator: " ") }.joined(separator: ", "), abstractText: $0.data.abstractNote, attachmentKey: nil, fullText: nil)
                }
                DispatchQueue.main.async { completion(.success(papers)) }
            } catch { DispatchQueue.main.async { completion(.failure(error)) } }
        }
    }
    func fetchFullText(attachmentKey: String, completion: @escaping (Result<String, Error>) -> Void) {
        queue.async { do { let data = try self.run(["--local", "--library-id", "0", "--library-type", "user", "fulltext", "get", attachmentKey, "--output", "json"]); let result = try JSONDecoder().decode(ZoteroFullText.self, from: data); DispatchQueue.main.async { completion(.success(result.content)) } } catch { DispatchQueue.main.async { completion(.failure(error)) } } }
    }
    private func run(_ args: [String]) throws -> Data {
        let p = Process(); p.executableURL = URL(fileURLWithPath: executable); p.arguments = args
        let out = Pipe(); let err = Pipe(); p.standardOutput = out; p.standardError = err; try p.run(); p.waitUntilExit()
        guard p.terminationStatus == 0 else { throw NSError(domain: "Zotero", code: Int(p.terminationStatus), userInfo: [NSLocalizedDescriptionKey: String(data: err.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? "Zotero command failed"]) }
        return out.fileHandleForReading.readDataToEndOfFile()
    }
    private struct ZoteroItem: Codable { let key: String; let data: ItemData }
    private struct ItemData: Codable { let title: String; let abstractNote: String; let itemType: String; let creators: [Creator] }
    private struct Creator: Codable { let firstName: String?; let lastName: String?; let name: String? }
    private struct ZoteroFullText: Codable { let content: String }
}
