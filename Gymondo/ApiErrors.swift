import Foundation

struct ResponseError: Error {
    enum ErrorKind {
        case invalidResponse
        case noImage
    }
    
    let kind: ErrorKind
    
    init(kind: ErrorKind) {
        self.kind = kind
    }
    
     var description: String {
        switch kind {
        case .invalidResponse:
            return "Invalid Response"
        case .noImage:
            return "No Image"
        default:
            return "Default"
        }
    }
}
