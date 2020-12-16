//
//  NetworkManager.swift
//  CountDown
//
//  Created by Rodrigo Hernández Gómez on 04/12/2020.
//

import Foundation
import Alamofire

class Post: Codable {
    
    let userId: Int
    let title: String
    let body: String
    
    init(title: String, body: String, userId: Int) {
        self.title = title
        self.body = body
        self.userId = userId
    }
    
    
}

class Network: PicsumAPI {
    
        
    static var shared: Network = Network()
    
    func newPost(){
        
        let headers = ["content-type": "application/json; charset=UTF-8"]

        let newPost = Post(title: "Nuevo Post", body: "vete a hacer la compra", userId: 3)
        
        let encoder = JSONEncoder.init()
        
        var postData: Data!
        
        do {
            let postSerilized = try! encoder.encode(newPost)
            postData = try! Data(encoder.encode(newPost))
        }catch{
            print(error)
        }

        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
        })

        dataTask.resume()
        
    }
    
    func getPhoto(completionHandler: @escaping (_ data: Data) -> Any) {
        
        //1 Define the Request
        var urlRequest = URLRequest(url: URL(string: "https://picsum.photos/200/300")!)
        
        urlRequest.httpMethod = "GET"
        
        //2 Set addiotional headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept-Language")
        
        
        URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/200/300")!){data,response,error in
            
            completionHandler(data!)
            
        }.resume()
        
        AF.request("https://picsum.photos/200/300").response { response in
            debugPrint(response)
        }
        
    }
    
}


protocol PetsAPI {
    
    //PET
    func postPet()
    func putPet()
    func getPet()
    
}

extension Network : PetsAPI {
    
    func postPet() {
        
    }
    
    func putPet() {
        
    }
    
    func getPet() {
        
    }
    
}

protocol PicsumAPI {
    
    func getPhoto(completionHandler: @escaping (_ data: Data) -> Any)
    
}


