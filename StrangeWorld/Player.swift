//
//  Player.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation

class Player: Creature {
    var baseStr, baseDex, baseDef, baseMhp: Int!
    var dict: NSMutableDictionary!
    
    func load(fromDictionary dict : NSMutableDictionary) {
        self.dict = dict
        self.hp = 1
        load()
        refresh()
    }
    
    func load() {
        battleImg = "player.png"
        self.baseStr = dict["STR"] as! Int
        self.baseDex = dict["DEX"] as! Int
        self.baseDef = dict["DEF"] as! Int
        self.baseMhp = dict["HP"] as! Int
        self.str = self.baseStr
        self.dex = self.baseDex
        self.def = self.baseDef
        self.mhp = self.baseMhp
        self.dmgMin = self.baseStr
        self.dmgRange = self.baseStr
        NSLog("mhp%d", self.mhp)
        let eqdict = (dict["PROPERTY"] as! NSDictionary)["EQUIPPING"] as! NSDictionary
        let itemDict = ModelHandler.Instance.itemData.allDict
        for typeName: String in (eqdict.allKeys as! [String]) {
            let typeItem = itemDict[typeName] as! NSDictionary
            let itemID = eqdict[typeName] as? String
            if (itemID != nil && itemID != GlobalName.NONE) {
                let item = typeItem[itemID!] as! NSDictionary
                addItemEffect(item)
            }
        }
        if (self.hp > self.mhp) {
            self.hp = self.mhp
        }
    }
    
    func refresh() {
        self.hp = self.mhp
    }
    
    private func addItemEffect(item: NSDictionary) {
        for effectName: String in (item.allKeys as! [String]) {
            switch effectName {
                case "HP":
                    self.mhp = self.mhp + (item[effectName] as! Int)
                    break
                case "STR":
                    self.str = self.str + (item[effectName] as! Int)
                    break
                case "DEX":
                    self.dex = self.dex + (item[effectName] as! Int)
                    break
                case "DEF":
                    self.def = self.def + (item[effectName] as! Int)
                    break
                case "DMG_MIN":
                    self.dmgMin = self.dmgMin + (item[effectName] as! Int)
                    break
                case "DMG_RANGE":
                    self.dmgRange = self.dmgRange + (item[effectName] as! Int)
                    break
                default:
                    break
            }
        }
    }
}
