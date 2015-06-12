//
//  sVpo.swift
//  sVpo
//
//  Created by Luciano Colosio on 6/12/15.
//  Copyright (c) 2015 Luciano Colosio. All rights reserved.
//

import Foundation

public class sVpo: NSObject {
    let dictionary: NSDictionary
    
    public init(dict: NSDictionary) {
        self.dictionary = dict
    }
    
    private func getValue(dict: NSDictionary, path: String, faultback: AnyObject? = nil) -> AnyObject? {
        let split: NSArray = path.componentsSeparatedByString(".")
        let search: String = (split[0] as? String)!
        
        if let branch: AnyObject = dict.valueForKey(search){
            if split.count > 1 {
                return getValue(branch as! NSDictionary, path: path.stringByReplacingOccurrencesOfString(search + ".", withString: ""), faultback: faultback)
            } else {
                return branch;
            }
        }
        
        return faultback
    }
    
    public func get(path: String, faultback: AnyObject? = nil) -> AnyObject? {
        return getValue(self.dictionary, path: path, faultback: faultback)
    }
    
    public func some(paths: NSArray, faultback: AnyObject? = nil) -> AnyObject? {
        for path in paths {
            if let result:AnyObject = getValue(self.dictionary, path: path as! String) {
                return result
            }
        }
        
        return faultback
    }

}