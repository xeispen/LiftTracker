//
//  exercise.swift
//  LiftTracker
//
//  Created by Peisen Xue on 7/4/17.
//  Copyright © 2017 Peisen Xue. All rights reserved.
//

import Foundation
import UIKit
import os.log


//MARK: Types

struct PropertyKey {
    static let name = "name"
    static let weight = "weight"
    static let set = "set"
    static let rep = "rep"
}


class Exercise: NSObject, NSCoding {
    
    
    //MARK: Properties
    
    var name: String
    var weight: Int?
    var set: Int?
    var rep: Int?
    
    
    init?(name: String, weight: Int?, set: Int?, rep: Int?){
        
        guard !name.isEmpty else {return nil}
        
        //guard (weight >= 0) && (set >= 0) && (rep >= 0)
        //else {return nil}
        
        
        self.name = name
        self.weight = weight
        self.set = set
        self.rep = rep
    }
    
    //Prepares the class to be archived
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(weight, forKey: PropertyKey.weight)
        aCoder.encode(set, forKey: PropertyKey.set)
        aCoder.encode(rep, forKey: PropertyKey.rep)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name of Exercise object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        let weight = aDecoder.decodeObject(forKey: PropertyKey.weight)
        
        let set = aDecoder.decodeObject(forKey: PropertyKey.set)
        
        let rep = aDecoder.decodeObject(forKey: PropertyKey.rep)
        
        self.init(name: name, weight: weight as? Int, set: set as? Int, rep: rep as? Int)
        
    }
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises")
    
    
    
}
