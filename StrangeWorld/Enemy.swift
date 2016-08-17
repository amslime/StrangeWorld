//
//  Enemy.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/16.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation

class Enemy: Creature {
    func load(enemyID id: String) {
        let dict = ModelHandler.Instance.enemyData as NSDictionary
        let me = dict[id] as! NSDictionary
        for stat: String in (me.allKeys as! [String]) {
            switch stat {
                case "HP":
                    self.mhp = me[stat] as! Int
                    break
                case "STR":
                    self.str = me[stat] as! Int
                    break
                case "DEX":
                    self.dex = me[stat] as! Int
                    break
                case "DEF":
                    self.def = me[stat] as! Int
                    break
                case "DMG_MIN":
                    self.dmgMin = me[stat] as! Int
                    break
                case "DMG_RANGE":
                    self.dmgRange = me[stat] as! Int
                    break
                case "IMG":
                    self.battleImg = me[stat] as! String
                default:
                    break
            }

        }
    }
    
}
