//
//  Category.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/6/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//




import Foundation
import  UIKit

class CategoryModel {
    
    
    var name: String?
    var key: String?
    var color: String?
    
    
    init(name: String?, key: String?, color: String?){
        
        self.name = name
        self.key = key
        self.color = color
        
    }
}
