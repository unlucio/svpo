//
//  sVpo.swift
//  sVpo
//
//  Created by Luciano Colosio on 6/12/15.
//  Copyright (c) 2015 Luciano Colosio. All rights reserved.
//

import Foundation

public class sVpo {
    private let dictionary: NSDictionary
    
    public init(dictionary: NSDictionary) {
        self.dictionary = dictionary
    }
    
    public func get(path: String, faultback: AnyObject? = nil) -> AnyObject? {
        return getValue(dictionary, path: path) ?? faultback
    }
    
    public func some(paths: [String], faultback: AnyObject? = nil) -> AnyObject? {
        for path in paths {
            if let result = getValue(dictionary, path: path) {
                return result
            }
        }
        
        return faultback
    }
    
}

private extension sVpo {
    func getValue(dictionary: NSDictionary, path: String) -> AnyObject? {
        let split = path.componentsSeparatedByString(".")
        guard let search = split.first else {
            return nil
        }
        
        guard let branch = dictionary.valueForKey(search)  else {
            return nil
        }
        
        if let dictionary = branch as? NSDictionary where split.count > 1 {
            return getValue(dictionary, path: path.stringByReplacingOccurrencesOfString(search + ".", withString: ""))
        }
        
        return branch;
    }
}