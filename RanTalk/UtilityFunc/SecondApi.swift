//
//  SecondApi.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

enum HttpMethods : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}


class SecondApi: NSObject{

    var request : NSMutableURLRequest?
    var session : URLSession?
    
    
    static func instance() ->  SecondApi{
        
        return SecondApi()
    }

    func makeAPICalls(url: String, params: [String : Any] , method: HttpMethods, success:@escaping ( Data? ,HTTPURLResponse?  , NSError?, String ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        

        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache"
        ]
        
        
        let requestData = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        
        request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        
        request?.allHTTPHeaderFields = headers

        
        print("URL = \(url)")
        
        print("params = \(params)")
        
        
        request?.httpMethod = method.rawValue
        
  
        NSLog("\(requestData)")
        print("requestdata = \(requestData)")
        
        request?.httpBody = requestData as Data
        

        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        //paramString.data(using: String.Encoding.utf8)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                if let response = response as? HTTPURLResponse, 200...500 ~= response.statusCode {
                    print("second requestdata = \(requestData)")
                    print("statusCode should be 200, but is \(response.statusCode)")
                    print("response = \(response)")
                    
                    let responsedata = String(data: data, encoding: .utf8)!
                    print("response data = \(responsedata)")
                    
                    success(data , response , error as NSError?, responsedata)
                    print("third requestdata = \(requestData)")
                    
                    
                    
                    
                } else {
                    
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                    
                    print("Fail")
                }
            }
            
            }.resume()
        
    }
    

}
