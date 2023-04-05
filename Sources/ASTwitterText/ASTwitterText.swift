import Foundation

public class ASTwitterText {
    
   static public func checkTextCount(text: String) -> Int {
        
        var count = 0
        
        count += getURLsWeight(text: text)
        count += getHashtagWeight(text: text)
        count += getCharWeight(text: text)
        
        print("The text contains \(count) characters.")
        return count
    }
    
  static private func getURLsWeight(text: String) -> Int {
        
        let urlPattern = "(?<!\\w)(https?:\\/\\/)?(www\\.)?([\\w-]+\\.[\\w-]+\\.?)([\\/\\w-]*)*\\/?\\b"
        var count = 0
        // Count URL links with default length of 23 characters
        guard let regex = try? NSRegularExpression(pattern: urlPattern, options: .caseInsensitive) else {return count}
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        for match in matches {
            let urlRange = Range(match.range, in: text)!
            let urlString = String(text[urlRange])
            count += 23
            count -= urlString.count
        }
        return count
    }
    
    static private func getHashtagWeight(text: String) -> Int {
        var count = 0
        //         Count hashtags
        let hashtagPattern = "#\\w+"
        guard let hashtagRegex = try? NSRegularExpression(pattern: hashtagPattern, options: .caseInsensitive) else {
            print("Error creating hashtag regular expression")
            return count
        }
        
        let hashtagMatches = hashtagRegex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        for match in hashtagMatches {
            let hashtagRange = Range(match.range, in: text)!
            let hashtagString = String(text[hashtagRange])
            count += hashtagString.count
            print("hashtag text: \(hashtagString)")
        }
        return count
    }
    
    static private func getCharWeight(text: String) -> Int {
        
        var count = 0
        
        text.forEach { (char) in
            
            let scalar = char.unicodeScalars.first!
            if scalar.isASCII || (scalar.value >= 0x0600 && scalar.value <= 0x06FF) {
                // If the character is an ASCII character or an Arabic character
                // increment the count variable by 1
                count += 1
            } else if scalar.properties.isEmoji || scalar.properties.isUnifiedIdeograph {
                // If the character is an emoji or JCK character or vetname
                // increment the count variable by 2
                count += 2
            }
        }
        return count
    }
    
}

