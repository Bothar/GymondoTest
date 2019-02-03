import Foundation

struct Constants {
    //API URLS
    static let kAPI_BASE_URL = "https://wger.de"
    static let kAPI_EXERCICES_URL = "/api/v2/exercise"
    static let kAPI_EXER_INFO_URL = "/api/v2/exerciseinfo/"
    static let kAPI_EXER_IMAGE_URL = "/api/v2/exerciseimage/"
    
    //API PARAMETER KEYS
    static let kAPI_LANGUAGE_KEY = "language"
    static let kAPI_PAGE_KEY = "page"
    static let kAPI_STATUS_KEY = "status"
    
    //API PARAMETER VALUES
    static let kAPI_LANGUAGUE_ENG_VALUE = "2"
    static let kAPI_STATUS_EX_DATABASE = "2"
    
    //JSON KEYS
    static let kJSON_RESULTS = "results"
    static let kJSON_ID = "id"
    static let kJSON_NAME = "name"
    static let kJSON_CATEGORY = "category"
    static let kJSON_DESCRIPTION = "description"
    static let kJSON_MUSCLES = "muscles"
    static let kJSON_EQUIPMENT = "equipment"
    static let kJSON_IMAGE = "image"
    
    //CELL IDS
    static let kCELL_EXERCISE_ID = "exerciseCell"
    
    //SEGUES
    static let kSEGUE_DETAIL = "toDetail"
    
    //IMAGE NAMES
    static let kIMAGE_PLACEHOLDER = "placeholder"
}
