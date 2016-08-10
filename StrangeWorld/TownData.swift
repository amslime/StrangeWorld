//
//  TownData.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/10.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation

class TownData {
    var totalTownData: NSDictionary!
    var currentTown: NSDictionary!
    
    func load(fromDictionary dict : NSDictionary) {
        totalTownData = dict
    }
    
    func setCurrentTown(townNamed name: String) {
        currentTown = totalTownData[name] as! NSDictionary
    }
    
    func getFacilitiesList() -> Array<String> {
        if (totalTownData == nil) {
            return Array<String>()
        }
        return currentTown["FACILITIES"] as! Array<String>
    }
    
    func getTownName() -> String {
        return currentTown["NAME"] as! String
    }
    
    func getTownComment() -> String {
        return currentTown["COMMENT"] as! String
    }
    
    func getFacilityByName(facilityName name : String) -> NSDictionary {
       return currentTown[name] as! NSDictionary
    }
    
}
