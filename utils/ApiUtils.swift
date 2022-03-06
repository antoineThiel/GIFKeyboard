//
//  ApiUtils.swift
//  GIFKeyboard
//
//  Created by Antoine Thiel on 05/03/2022.
//

import Foundation

class ApiUtils {
    
    private var dataTask: URLSessionDataTask?
    let apikey = "TU3LOF1ELBH6"
    var arrayResponse: [Response] = []
    
    public func getGifBySearchTerm(searchTerm: String, completion: @escaping (Error?, [Response]?) -> Void){
        let limit = 5
        let media_filter = "tinygif"
        let searchRequest = URLRequest(
            url: URL(string: String(format: "https://g.tenor.com/v1/search?q=%@&key=%@&limit=%d&&media_filter=tinygif", searchTerm, apikey, limit, media_filter))!
        )
        
        searchGif(urlRequest:searchRequest) { (results) in
            switch results{
                case .success(let responseData):
                let array = responseData.arrayReponseData
                    for media in array {
                        self.arrayResponse.append(media)
                        }
                    break
                case .failure(let e):
                    print(e)
                    break
            }
        
            if self.arrayResponse.count > 0 {
                completion(nil, self.arrayResponse)
            }
            completion(ErrorUtils.buildError(code: .gifNotFound), nil)
        }
    }


    func searchGif(urlRequest: URLRequest,completion: @escaping(Result<ResponseData,Error>) -> Void) {
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask: error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else{
                print("Empty Data")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
