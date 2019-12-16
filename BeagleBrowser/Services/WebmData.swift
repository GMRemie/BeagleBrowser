//
//  WebmData.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/13/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import Foundation


class WebmLoader{
    
    
    init() {
        
    }
    
    static let shared = WebmLoader()
    
    func webmData(_ parameters: String, completionHandler: @escaping (Data?, Error?) -> Void){
         //.. Code process
        let url = URL(string: parameters)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!) { (_Data, _Response, _Error) in
            if _Error != nil {
                completionHandler(nil,_Error!)
                print("Error")
                return
            }
            
            guard let response = _Response as? HTTPURLResponse, response.statusCode == 200 else{
                print("Error2")
                completionHandler(nil,BeagleErrors.badResponse)
                return
            }
            
            // we should have a video
            print("Printing Data: ",_Data!)
            completionHandler(_Data!,nil)
        }
        task.resume()
    }
    
    
}
