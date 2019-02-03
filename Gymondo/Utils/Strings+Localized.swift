import Foundation

func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}


extension String {
    static let equipmentTitle = NSLocalizedString("equipmentTitle")
    static let musclesTitle = NSLocalizedString("musclesTitle")
    static let errorTitle = NSLocalizedString("errorTitle")
    static let okButton = NSLocalizedString("okButton")
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
