//
//  URLRequestExtension.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/13/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import Foundation

extension URLRequest {
    var isHttpLink: Bool {
        return self.url?.scheme?.contains("https") ?? false
    }
}
