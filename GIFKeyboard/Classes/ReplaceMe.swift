let apikey = "TU3LOF1ELBH6"


    public func run(){
        requestData()
    }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    requestData()

    return true
  }

  /**
   Execute web request to retrieve the top GIFs returned(in batches of 8) for the given search term.
   */
  func requestData()
  {
    // the test search term
    let searchTerm = "excited"

    // Define the results upper limit
    let limit = 8

    // make initial search request for the first 8 items using default locale of EN_US
    let searchRequest = URLRequest(url: URL(string: String(format: "https://g.tenor.com/v1/search?q=%@&key=%@&limit=%d",
                                                             searchTerm,
                                                             apikey,
                                                             limit))!)

    makeWebRequest(urlRequest: searchRequest, callback: tenorSearchHandler)

    // Data will be loaded by each request's callback
  }

  /**
   Async URL requesting function.
   */
  func makeWebRequest(urlRequest: URLRequest, callback: @escaping ([String:AnyObject]) -> ())
  {
    // Make the async request and pass the resulting json object to the callback
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
          // Push the results to our callback
          callback(jsonResult)
        }
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
    task.resume()
  }

  /**
   Web response handler for search requests.
   */
  func tenorSearchHandler(response: [String:AnyObject])
  {
    // Parse the json response
    let responseGifs = response["results"]!

    // Load the GIFs into your view
    print("Result GIFS: \(responseGifs)")

  }
