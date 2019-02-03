import Foundation
import AlamofireImage

class Exercise {
    let id: Int!
    let name: String!
    var category: String?
    var description: String?
    var image: Image = Image(named: Constants.kIMAGE_PLACEHOLDER)!
    var equipment: [String] = []
    var muscles: [String] = []
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    var equipmentStringList: String {
        var str = ""
        for item in equipment {
            str += item
            if item != equipment.last {
                str += ", "
            }
        }
        return str
    }
    
    var musclesStringList: String {
        var str = ""
        for item in muscles {
            str += item
            if item != muscles.last {
                str += ", "
            }
        }
        return str
    }
}
