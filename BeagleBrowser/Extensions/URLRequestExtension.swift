//
//  URLRequestExtension.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/13/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import Foundation

extension URLRequest {
    var isWebmLink: Bool {
        return self.url?.absoluteString.hasSuffix("webm") ?? false
        //return self.url?.scheme?.contains("https") ?? false
    }
}
