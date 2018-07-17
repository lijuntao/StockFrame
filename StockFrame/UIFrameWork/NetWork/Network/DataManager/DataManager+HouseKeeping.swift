//
//  DataManager+HouseKeeping.swift
//  StockFrame
//
//  Created by fdt on 2018/7/17.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataManager {
    
    func doAuthConnect(_ sender: DataHelper) {
        sender.doAuthConnect(withClientID: Constant.system.uuid, appID: Constant.system.productName, ver: Constant.system.version)
    }
    
    func handleConnectChallenge(_ base: JPacketReceiveBase, sender: DataHelper) {
        sender.doAuthConnectResponse(base, country: Constant.system.country, lang: Constant.system.language)
    }
    
    func handleEncryptPacket(_ base: JPacketReceiveBase, sender: DataHelper) {
        sender.handleEncryptPacket(base)
    }
    
    func handleConnectStatus(_ packet:JPacketReceiveBase, sender: DataHelper) {
        let pkt = packet as! ConnectStatus
        sender.handleAuthConnectDone()
        sender.dataAESKey = pkt.key
    }
    
    // 更新server時間
    func handleAliveStatus(_ packet:JPacketReceiveBase, sender: DataHelper){
        // 更新server時間
        let aliveStatus = packet as! AliveStatus;
        FDTLog.logDebug("server timer \(aliveStatus.time!)")
    }
}
