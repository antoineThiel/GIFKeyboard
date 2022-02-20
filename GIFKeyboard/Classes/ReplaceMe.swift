let apikey = "TU3LOF1ELBH6"
private var dataTask: URLSessionDataTask?
var arrayResponse: [Response] = []



    public func run(){
        getGifBySearchTerm(searchTerm: "excited")

    }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    return true
  }

  /**
   Execute web request to retrieve the top GIFs returned(in batches of 8) for the given search term.
   */

func getGifBySearchTerm(searchTerm: String){

    // Define the results upper limit
    let limit = 4
      
    let media_filter = "tinygif"
    let searchRequest = URLRequest(url: URL(string: String(format: "https://g.tenor.com/v1/search?q=%@&key=%@&limit=%d&&media_filter=tinygif",
                                                             searchTerm,
                                                             apikey,
                                                             limit,
                                                            media_filter))!)
    searchGif(urlRequest:searchRequest) {  (results) in
        switch results{
        case .success(let responseData):
            let array = responseData.arrayReponseData
            for media in array {
                arrayResponse.append(media)
                print(media,separator: "\n\n")
            }
            break
        case .failure(let e):
            print(e)
            break
        }
    }
}

  /**
   Async URL requesting function.
   */

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
