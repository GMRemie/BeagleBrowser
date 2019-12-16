//
//  GoogleAPI.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/16/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import Foundation

internal struct GoogleAPI {
    
    
    internal static func generateURL(_ term: String) -> URL{
        
        // cx=001737391559739302589:g0vfcoxudxx
        
        // Seperate by spaces
        let replaced = term.replacingOccurrences(of: " ", with: "+")
        print(replaced)
        let urlString = "https://www.google.com/search?q=" + replaced
        
        
        return URL(string: urlString)!

    }
}
