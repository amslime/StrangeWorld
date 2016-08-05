//
//  PlayerViewController.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var strLabel: UILabel!
    @IBOutlet weak var dexLabel: UILabel!
    @IBOutlet weak var commetLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var dmgLabel: UILabel!
    @IBOutlet weak var itemPicker: UIPickerView!
    
    var itemTypeDict: NSDictionary!
    var itemGroupDict: NSDictionary!
    var itemType: Array = ["武器", "护甲", "杂项"]
    var itemTypeId: Array = ["WEAPON", "ARMOR", "MISC"]
    var itemInGroupArray: Array<String>!
    var selectedTypeId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemPicker.dataSource = self
        self.itemPicker.delegate = self
        
        // TODO, wait for update
        let player = ModelHandler.Instance.player
        strLabel.textColor = UIColor.redColor()
        strLabel.text = String(player.str)
        dexLabel.textColor = UIColor.blueColor()
        dexLabel.text = String(player.dex)
        defLabel.textColor = UIColor.cyanColor()
        defLabel.text = String(player.def)
        hpLabel.textColor = UIColor.redColor()
        hpLabel.text = String(player.mhp)
        dmgLabel.text = "5 - 10"
        
        itemTypeDict = ModelHandler.Instance.player.dict["PROPERTY"] as! NSDictionary
        itemGroupDict = itemTypeDict[itemTypeId[0]] as! NSDictionary
        itemInGroupArray = itemGroupDict.allKeys as! Array<String>
        selectedTypeId = itemTypeId[0]
        updateCommentLabel(didSelectRow: self.itemPicker.selectedRowInComponent(1))
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
        updateCommentLabel(didSelectRow: itemPicker.selectedRowInComponent(1))
    }
    
    func updateCommentLabel(didSelectRow row: Int) {
        if (itemInGroupArray.count <= 0) {
            commetLabel.text = ""
            return
        }
        let id = itemInGroupArray[row]
        let typeDict = ModelHandler.Instance.itemData.allDict[selectedTypeId] as! NSDictionary
        let item = typeDict[id] as! NSDictionary
        var comment = item["COMMENT"] as? String
        if (comment == nil) {
            comment = "未知装备"
        }
        commetLabel.text = comment
    }
}
