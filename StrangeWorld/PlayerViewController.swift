//
//  PlayerViewController.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var useButton: UIButton!
    @IBOutlet weak var strLabel: UILabel!
    @IBOutlet weak var dexLabel: UILabel!
    @IBOutlet weak var commetLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var dmgLabel: UILabel!
    @IBOutlet weak var itemPicker: UIPickerView!
    
    private var itemTypeDict: NSDictionary!
    private var itemGroupDict: NSDictionary!
    private var itemType: Array = ["武器", "护甲", "杂项"]
    private var itemTypeId: Array = ["WEAPON", "ARMOR", "MISC"]
    private var itemInGroupArray: Array<String>!
    private var selectedTypeId: String!
    private var onChooseItem: NSDictionary!
    private var onChooseId: String!
    private var equippingDict: NSDictionary!
    private var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemPicker.dataSource = self
        self.itemPicker.delegate = self
        
        // TODO, wait for update
        player = ModelHandler.Instance.player as Player
        equippingDict = (player.dict["PROPERTY"] as! NSMutableDictionary)["EQUIPPING"] as! NSMutableDictionary
        
        updatePlayerStats()
        
        itemTypeDict = player.dict["PROPERTY"] as! NSMutableDictionary
        itemGroupDict = itemTypeDict[itemTypeId[0]] as! NSMutableDictionary
        itemInGroupArray = itemGroupDict.allKeys as! Array<String>
        selectedTypeId = itemTypeId[0]
        onChooseItem = updateInfo(didSelectRow: self.itemPicker.selectedRowInComponent(1))
    }
    
    func updatePlayerStats() {
        strLabel.textColor = UIColor.redColor()
        strLabel.text = String(player.str)
        dexLabel.textColor = UIColor.blueColor()
        dexLabel.text = String(player.dex)
        defLabel.textColor = UIColor.cyanColor()
        defLabel.text = String(player.def)
        hpLabel.textColor = UIColor.redColor()
        hpLabel.text = String(player.mhp)
        let minDmg = player.dmgMin
        let maxDmg = minDmg + player.dmgRange
        dmgLabel.text = String(minDmg) + "~" + String(maxDmg)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return itemType.count
        } else if (component == 1){
            return itemInGroupArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return itemType[row]
        } else if (component == 1) {
            let id = itemInGroupArray[row]
            let typeDict = ModelHandler.Instance.itemData.allDict[selectedTypeId] as! NSDictionary
            let item = typeDict[id] as! NSDictionary
            return item["DISPLAY_NAME"] as? String
        } else {
            return "Unknow"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            selectedTypeId = itemTypeId[row]
            itemGroupDict = itemTypeDict[selectedTypeId] as! NSDictionary
            itemInGroupArray = itemGroupDict.allKeys as! Array<String>
            self.itemPicker.reloadComponent(1)
        } else if (component == 1) {

        }
        onChooseItem = updateInfo(didSelectRow: itemPicker.selectedRowInComponent(1))
    }
    
    func updateInfo(didSelectRow row: Int) -> NSDictionary? {
        if (itemInGroupArray.count <= 0) {
            NSLog("0000")
            commetLabel.text = ""
            self.useButton.setTitle("", forState: .Normal)
            self.sellButton.setTitle("", forState: .Normal)
            return nil
        }
        onChooseId = itemInGroupArray[row]
        let typeDict = ModelHandler.Instance.itemData.allDict[selectedTypeId] as! NSDictionary
        let item = typeDict[onChooseId] as! NSDictionary
        var comment = item["COMMENT"] as? String
        if (comment == nil) {
            comment = "未知装备"
        }
        
        if (selectedTypeId != "MISC") {
            let eqid = self.equippingDict[selectedTypeId] as? String
            if (eqid == nil || eqid != onChooseId) {
                self.useButton.setTitle(GlobalName.EQUIP, forState: .Normal)
            } else {
                self.useButton.setTitle(GlobalName.UNEQUIP, forState: .Normal)
            }
        } else {
            self.useButton.setTitle(GlobalName.USE, forState: .Normal)
        }
        
        self.sellButton.setTitle(GlobalName.SELL, forState: .Normal)
        commetLabel.text = comment
        return item
    }
    
    @IBAction func useButtonClicked(sender: AnyObject) {
        if (useButton.currentTitle == GlobalName.EQUIP) {
            NSLog("equipping")
            equippingDict.setValue(onChooseId, forKey: selectedTypeId)
            player.load()
            updatePlayerStats()
            useButton.setTitle(GlobalName.UNEQUIP, forState: .Normal)
        }
        else if (useButton.currentTitle == GlobalName.UNEQUIP) {
            NSLog("unEquipping")
            equippingDict.setValue(GlobalName.NONE, forKey: selectedTypeId)
            player.load()
            updatePlayerStats()
            useButton.setTitle(GlobalName.EQUIP, forState: .Normal)
        }
        else if (useButton.currentTitle == GlobalName.USE) {
            NSLog("use")
        }
    }
}
