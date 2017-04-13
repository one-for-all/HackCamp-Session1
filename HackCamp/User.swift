//
//  User.swift
//  HackCamp
//
//  Created by 迦南 on 4/12/17.
//  Copyright © 2017 迦南. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    var age: Int
    var score: Int = 0
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

}
