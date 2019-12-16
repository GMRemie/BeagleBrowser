//
//  StringExtension.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/16/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import Foundation

extension String {
    
    func isValidURL() -> Bool {
        let string: String?
        string = self
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }

        if !UIApplication.shared.canOpenURL(url) { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self)
    }


}
