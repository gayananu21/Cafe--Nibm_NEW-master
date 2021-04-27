


import Foundation
import  UIKit

class FoodModel {
    
    var description: String?
    var name: String?
    var price: String?
    var foodImage: String?
    var key: String?
    var discount: String?
    var availability: String?
    
    init(description: String?, name: String?, price: String?, foodImage: String?,  key: String?, availability: String?, discount: String?
){
        self.description = description
        self.name = name
        self.price = price
        self.foodImage = foodImage
        self.key = key
        self.discount = discount
        self.availability = availability
        
    }
}
