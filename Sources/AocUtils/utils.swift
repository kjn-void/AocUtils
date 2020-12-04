import Foundation

public func inputGet(separatedBy: String = "\n") -> [String] {
    let fileName = CommandLine.argc == 1 ? "input" : CommandLine.arguments[1]
    let cwdURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let fileURL = URL(fileURLWithPath: fileName, relativeTo: cwdURL).appendingPathExtension("txt")
    let content = try! String(contentsOf: fileURL, encoding: String.Encoding.utf8)
    return content.components(separatedBy: separatedBy).filter { !$0.isEmpty }
}

public func recordsGet() -> [String] {
    return inputGet(separatedBy: "\n\n")
      .map{ $0
              .replacingOccurrences(of: "\n", with: " ")
              .trimmingCharacters(in: .whitespacesAndNewlines)
      }
}

extension String {
    public func charAt(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }

    public func match(re: String) -> Bool {
        guard let re = try? NSRegularExpression(pattern: re) else { return false }
        let range = NSRange(location: 0, length: self.utf16.count)
        return re.firstMatch(in: self, options: [], range: range) != nil
    }

    public func groups(re: String) -> [String] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: re)
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return matches.map { match in
                return (0..<match.numberOfRanges).map {
                    let rangeBounds = match.range(at: $0)
                    guard let range = Range(rangeBounds, in: text) else {
                        return ""
                    }
                    return String(text[range])
                }
            }.first ?? []
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
