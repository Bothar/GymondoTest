import Foundation
import Alamofire
import AlamofireImage

class Session {
    static let shared = Session()
    
    private init() {}
    
    
    func fetchNewExercicies(atPage page: Int, completion: @escaping(Error?, [Exercise]) -> ()) {
        
        var urlParameters = URLComponents(string: Constants.kAPI_BASE_URL)!
        
        urlParameters.path = Constants.kAPI_EXERCICES_URL
        
        urlParameters.queryItems = [
            URLQueryItem(name: Constants.kAPI_LANGUAGE_KEY, value: Constants.kAPI_LANGUAGUE_ENG_VALUE),
            URLQueryItem(name: Constants.kAPI_STATUS_KEY, value: Constants.kAPI_STATUS_EX_DATABASE),
            URLQueryItem(name: Constants.kAPI_PAGE_KEY, value: "\(page)")
        ]
        
        Alamofire.request(urlParameters.url!, method: .get)
            .responseJSON { response in
                switch(response.result) {
                case .success(let JSON):
                    guard let JSON = JSON as? [String: Any],
                    let exerciciesList = JSON[Constants.kJSON_RESULTS] as? [[String: Any]] else {
                        completion(ResponseError(kind: .invalidResponse), [])
                        return
                    }
                    
                    let taskGroup = DispatchGroup()
                    var exercicies: [Exercise] = []
                    
                    for exerciceJSON in exerciciesList {
                        if let exerciceID = exerciceJSON[Constants.kJSON_ID] as? Int {
                            taskGroup.enter()
                            
                            self.requestExerciceInfo(id: exerciceID, completion: { err, exercice  in
                                taskGroup.leave()
                                guard let exercice = exercice else {
                                    print(err!.localizedDescription)
                                    return
                                }
                                exercicies.append(exercice)
                            })
                        }
                    }
                    
                    taskGroup.notify(queue: DispatchQueue.main, execute : {
                        completion(nil, exercicies)
                    })
                    
                case .failure(let error):
                    completion(error, [])
                }
        }
        
    }
    
    func requestExerciceInfo(id: Int, completion: @escaping(Error?, Exercise?) -> ()) {
        
        let url = Constants.kAPI_BASE_URL + Constants.kAPI_EXER_INFO_URL + "\(id)"
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch(response.result) {
                case .success(let JSON):
                    guard let JSON = JSON as? [String: Any],
                    let name = JSON[Constants.kJSON_NAME] as? String else {
                        completion(ResponseError(kind: .invalidResponse), nil)
                        return
                    }
                    
                    let exercice = Exercise(id: id, name: name)
                    
                    if let category = JSON[Constants.kJSON_CATEGORY] as? [String: Any],
                        let categoryName = category[Constants.kJSON_NAME] as? String {
                        exercice.category = categoryName
                    }
                    
                    exercice.description = JSON[Constants.kJSON_DESCRIPTION] as? String
                    
                    if let musclesList = JSON[Constants.kJSON_MUSCLES] as? [[String: Any]] {
                        for muscleJSON in musclesList {
                            if let muscleName = muscleJSON[Constants.kJSON_NAME] as? String {
                                exercice.muscles.append(muscleName)
                            }
                        }
                    }
                    
                    if let equipmentList = JSON[Constants.kJSON_EQUIPMENT] as? [[String: Any]] {
                        for equipmentJSON in equipmentList {
                            if let equipementName = equipmentJSON[Constants.kJSON_NAME] as? String {
                                exercice.equipment.append(equipementName)
                            }
                        }
                    }
                    
                    self.donwloadImageIfExist(id: id, completion: { err, image in
                        if let image = image {
                            exercice.image = image
                        } 
                        completion(nil, exercice)
                        
                    })
                    case .failure(let error):
                        completion(error, nil)
                }
        }
    }
    
    func donwloadImageIfExist(id: Int, completion: @escaping(Error?, Image?) -> ()) {
        
        let url = Constants.kAPI_BASE_URL + Constants.kAPI_EXER_IMAGE_URL + "\(id)"
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch(response.result) {
                case .success(let JSON):
                    guard let JSON = JSON as? [String: Any],
                        let urlImage = JSON[Constants.kJSON_IMAGE] as? String else {
                            completion(ResponseError(kind: .noImage), nil)
                            return
                    }
                    Alamofire.request(urlImage).responseImage { response in
                        if let image = response.result.value {
                            completion(nil, image)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    completion(error, nil)
                }
        }

    }
}
