import Foundation

public func inputGet(separatedBy: String = "\n") -> [String] {
    let fileName = CommandLine.argc == 1 ? "input" : CommandLine.arguments[1]
    let cwdURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let fileURL = URL(fileURLWithPath: fileName, relativeTo: cwdURL).appendingPathExtension("txt")
    let content = try! String(contentsOf: fileURL, encoding: String.Encoding.utf8)
    return content.components(separatedBy: separatedBy).filter { !$0.isEmpty }
}

public func recordsGet() -> [String] {
    return inputGet(separatedBy: "\n\n").map{ $0.replacingOccurrences(of: "\n", with: " ") }
}

extension String {
    public func charAt(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
