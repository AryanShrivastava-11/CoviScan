//
//  Results.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 29/10/21.
//

import SwiftUI

struct Result: Codable{
    let covid_percentage: Double
    let pneumonia_percentage: Double
    let normal_percentage: Double
    let prediction: String
}

class API{
    func fetchResult(image: UIImage, completion: @escaping (Result) -> () ){
        let imageData: Data = image.jpegData(compressionQuality: 0.99) ?? Data()
        let imageStr: String = imageData.base64EncodedString()

        guard let url: URL = URL(string: "https://covid19-detection-api.herokuapp.com/api/ios/image") else {
            print("invalid url")
            return
        }
//        https://api-ayush.herokuapp.com/api/ios/image   https://covid19-detection-api.herokuapp.com/api/ios/image
    
        //create parameters
        let paraStr: String = "image=\(imageStr)"
        let paraData: Data =  paraStr.data(using: .utf8) ?? Data()

        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = paraData

        //require for sending the large data
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        //send the request
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print("Invalid Data")
                return
            }
            //show response in string
//            let responseStr: String = String(data: data, encoding: .utf8) ?? "naah try again"
//            print(responseStr)

//
            let newData = try! JSONDecoder().decode(Result.self, from: data)
            print(newData)
            
            DispatchQueue.main.async {
                
                completion(newData)
                
            }
//                    let newData = responseStr.data(using: .utf8)!
//                    do {
//                        if let jsonArray = try JSONSerialization.jsonObject(with: newData, options : .allowFragments) as? [Dictionary<String,Any>]
//                        {
//                            print(jsonArray) // use the json here
//                        } else {
//                            print("bad json")
//                        }
//                    } catch let error as NSError {
//                        print(error)
//                    }
        }
        .resume()


    }
}
