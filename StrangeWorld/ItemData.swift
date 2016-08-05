//
//  ItemData.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/5.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation

class ItemData {
    var weapon: Dictionary<String, AnyObject>!
    var armor: Dictionary<String, AnyObject>!
    var misc: Dictionary<String, AnyObject>!
    
    func load(fronDictionary dict : Dictionary<String, AnyObject?>) {
        self.weapon = dict["WEAPON"] as! Dictionary
        self.armor = dict["ARMOR"] as! Dictionary
        self.misc = dict["MISC"] as! Dictionary
    }    
}
