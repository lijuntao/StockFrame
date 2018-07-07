//
//  DataManager.swift
//  StockFrame
//
//  Created by fdt on 2018/7/6.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

protocol DataManagerDelegate: NSObjectProtocol {
    func getHostType(_ type: ServerType) -> String
    func getPortType(_ type: ServerType) -> String
}

class DataManager: NSObject, ResponseDataHandler, NetworkConnectStatusDelegate, DataHelperServerInfoDelegate {
    
    static let ALIVE_TIMESPAN:TimeInterval = 30
    var loginDataHelper: DataHelper!
    var quoteDataHelper: DataHelper!
    var tradeDateHelper: DataHelper!
    
    weak var delegate : DataManagerDelegate!
    
    var isSuspended: Bool = false
    override init() {
        super.init()
        self.initParams()
    }
    
    //MARK 对外接口
    func doConnect() -> Void {
        if let ip = self.dh_getServerHostSender(loginDataHelper),
            let port = self.dh_getServerPortSender(loginDataHelper){
            self.loginDataHelper.connect(toRTServer: ip,
                                         onPort: Int32(port)!,
                                    connectionStage: ConnectionServerStage_ByServerLoc)
            self.loginDataHelper.dataAES_IV = "8765432112345678".data(using: String.Encoding.utf8)
        } else {
            FDTLog.logInfo("登录连接失败")
        }
        
        if let ip = self.dh_getServerHostSender(quoteDataHelper),
            let port = self.dh_getServerPortSender(quoteDataHelper){
            self.quoteDataHelper.connect(toRTServer: ip,
                                         onPort: Int32(port)!,
                                         connectionStage: ConnectionServerStage_ByServerLoc)
            self.loginDataHelper.dataAES_IV = "8765432112345678".data(using: String.Encoding.utf8)
        } else {
            FDTLog.logInfo("行情连接失败")
        }
        
        if let ip = self.dh_getServerHostSender(tradeDateHelper),
            let port = self.dh_getServerPortSender(tradeDateHelper){
            self.tradeDateHelper.connect(toRTServer: ip,
                                         onPort: Int32(port)!,
                                         connectionStage: ConnectionServerStage_ByServerLoc)
            self.tradeDateHelper.dataAES_IV = "8765432112345678".data(using: String.Encoding.utf8)
        } else {
            FDTLog.logInfo("交易连接失败")
        }
    }
    
    func doDisConnect() -> Void {
        self.loginDataHelper.disConnectRT(withKeepRunning: false, resetHost: true)
        self.quoteDataHelper.disConnectRT(withKeepRunning: false, resetHost: true)
        self.tradeDateHelper.disConnectRT(withKeepRunning: false, resetHost: true)
    }
    
    @objc func doAliveForSender(_ sender: Any) {
        let timer = sender as! Timer
        
        if timer == quoteDataHelper.timerAlive {
            quoteDataHelper.nAliveCheck += 1
            if quoteDataHelper.nAliveCheck > 1 {
                quoteDataHelper.disConnectRT(withKeepRunning: true, resetHost: false)
            } else {
                quoteDataHelper.doAlive()
            }
        } else if timer == tradeDateHelper.timerAlive {
            tradeDateHelper.nAliveCheck += 1
            if tradeDateHelper.nAliveCheck > 1 {
                tradeDateHelper.disConnectRT(withKeepRunning: true, resetHost: false)
            } else {
                tradeDateHelper.doAlive()
            }
        }
    }
    
    func doSuspend() ->Void {
        self.loginDataHelper.doSuspend()
        self.quoteDataHelper.doSuspend()
        self.tradeDateHelper.doSuspend()
        isSuspended = true
        
        FDTLog.logDebug("doSuspend")
    }
    
    func doResume() ->Void {
        self.loginDataHelper.doResume()
        self.quoteDataHelper.doResume()
        self.tradeDateHelper.doResume()
        isSuspended = false
        
        FDTLog.logDebug("doResume")
    }
    
    func startAliveForSender() {
        //行情和交易
        self.quoteDataHelper.nAliveCheck = 0
        self.tradeDateHelper.nAliveCheck = 0
        DispatchQueue.main.async {
            self.quoteDataHelper.timerAlive?.invalidate()
            self.quoteDataHelper.timerAlive = nil
            self.quoteDataHelper.timerAlive = Timer.scheduledTimer(timeInterval: DataManager.ALIVE_TIMESPAN, target: self, selector: #selector(self.doAliveForSender(_:)), userInfo: nil, repeats: true)
            
            self.tradeDateHelper.timerAlive?.invalidate()
            self.tradeDateHelper.timerAlive = nil
            self.tradeDateHelper.timerAlive = Timer.scheduledTimer(timeInterval: DataManager.ALIVE_TIMESPAN, target: self, selector: #selector(self.doAliveForSender(_:)), userInfo: nil, repeats: true)
        }
    }
    
    func stopAliveForSender() {
        DispatchQueue.main.async {
            self.quoteDataHelper.timerAlive?.invalidate()
            self.quoteDataHelper.timerAlive = nil
            
            self.tradeDateHelper.timerAlive?.invalidate()
            self.tradeDateHelper.timerAlive = nil
        }
    }
    func resetAliveForSender(_ sender: DataHelper) {
        if sender.nAliveCheck > 0 {
            sender.nAliveCheck -= 1
        }
    }
    
    
    func doLogout() {
        
    }
    
    
    
    //MARK Private
    private func initParams() {
        //登录连线
        loginDataHelper = DataHelper(dataMgr: self)
        loginDataHelper.delegateNetworkConnect = self
        loginDataHelper.dataHelperServerInfoDelegate = self
        
        //行情连线
        quoteDataHelper = DataHelper(dataMgr: self)
        quoteDataHelper.delegateNetworkConnect = self
        quoteDataHelper.dataHelperServerInfoDelegate = self
        
        //交易连线
        tradeDateHelper = DataHelper(dataMgr: self)
        tradeDateHelper.delegateNetworkConnect = self
        tradeDateHelper.dataHelperServerInfoDelegate = self
    }
    
    //MARK: DataHelperServerInfoDelegate
    func dh_getServerHostSender(_ sender: DataHelper) -> String? {
        
        if sender == loginDataHelper {
            return self.delegate.getHostType(.ENUM_LOGINSERVER)
        } else if sender == quoteDataHelper {
            return self.delegate.getHostType(.ENUM_QUOTESERVER)
        } else if sender == tradeDateHelper {
            return self.delegate.getHostType(.ENUM_TRADESERVER)
        }
        return nil
    }
    
    func dh_getServerPortSender(_ sender: DataHelper) -> String? {

        if sender == loginDataHelper {
            return self.delegate.getPortType(.ENUM_LOGINSERVER)
        } else if sender == quoteDataHelper {
            return self.delegate.getPortType(.ENUM_QUOTESERVER)
        } else if sender == tradeDateHelper {
            return self.delegate.getPortType(.ENUM_TRADESERVER)
        }
        return nil
    }
    
    //MARK: ResponseDataHandler
    func handleJPacket(_ packet: JPacketReceiveBase, sender: DataHelper) {
        self.resetAliveForSender(sender)
        
        switch packet.pt {
        case EnumPacketPT_SymbolStatus:
            //
            break
        case EnumPacketPT_ConnectChallenge:
            break
        default:
            break
        }
    }
    
    func handleJPacketTimeout(_ packet: JPacketSendBase?, sender: DataHelper) {
        if let pkt = packet {
            FDTLog.logInfo("发送数据包(\(pkt.pt))超时")
        } else {
            FDTLog.logInfo("发送数据包(未知)超时")
        }
        
    }
    
    
    //MARK NetworkConnectStatusDelegate
    func handleConnect(_ status: Network_Status, obj: Any!, sender: Any!) {
        //
        switch status {
        case NetworkStatus_Connected:
            break
        default:
            break
        }
    }
    
    func handleDisconnectedSender(_ sender: Any!) {
        //断开连接
    }
    
    
}
