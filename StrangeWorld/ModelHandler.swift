//
//  ModelHandler.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation

class ModelHandler {
    class var Instance: ModelHandler{
        struct Static {
            static var instance: ModelHandler?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ModelHandler()
        }
        return Static.instance!
    }
    
    var player: Player!
    var itemData: ItemData!
    
    func resetFromView() {
        if (player == nil) {
            createCopyOfDataIfNeeded(fileNamed: "Player.plist")
            loadUser(fileNamed: "Player.plist")
        }
        if (itemData == nil) {
            loadItem(fileNamed: "Items.plist")
        }
    }
    
    func createCopyOfDataIfNeeded(fileNamed name: String) {
        let fileManager = NSFileManager.defaultManager()
        let writablePath = self.applicationDocumentsDirectoryFile(fileNamed: name)
        
        let fileExists = fileManager.fileExistsAtPath(writablePath)
        if (fileExists != true) {
            NSLog("Creating Data")
            let defaultFilePath = NSBundle.mainBundle().resourcePath as NSString!
            let filePath = defaultFilePath.stringByAppendingPathComponent(name) as String
            do {
                try fileManager.copyItemAtPath(filePath, toPath: writablePath)
            } catch {
                NSLog("File writing Error!")
            }
        }
        
    }
    
    func applicationDocumentsDirectoryFile(fileNamed name: String) -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(name) as String
        return path
    }
    
    func loadUser(fileNamed name: String) {
        let plistPath = applicationDocumentsDirectoryFile(fileNamed: name)
        let dict = NSDictionary(contentsOfFile: plistPath) as! Dictionary<String, AnyObject>
        player = Player()
        player.load(fromDictionary: dict)
    }
    
    func loadItem(fileNamed name: String) {
        let defauntFilePath = NSBundle.mainBundle().resourcePath as NSString!
        let plistPath = defauntFilePath.stringByAppendingPathComponent(name) as String
        let dict = NSDictionary(contentsOfFile: plistPath) as! Dictionary<String, AnyObject>
        itemData = ItemData()
        itemData.load(fromDictionary: dict)
    }
}