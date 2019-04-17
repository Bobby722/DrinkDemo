//
//  DrinkOrder.swift
//  DrinkDemo
//
//  Created by 林嫈沛 on 2019/4/17.
//  Copyright © 2019 lohaslab. All rights reserved.
//

import Foundation
struct DrinkArr:Codable {
    let name:String
    let drink:String
    let sweet:String
    let ice:String
    let size:String
    let time:String
}
class CdrinkOrder{
    let name:String
    let drink:String
    let sweet:String
    let ice:String
    let size:String
    let time:String
    
    init(name:String , drink:String , sweet:String , ice:String , size:String , time:String) {
        self.name = name
        self.drink = drink
        self.sweet = sweet
        self.ice = ice
        self.size = size
        self.time = time
    }
}
