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

class DataManager: NSObject, ResponseDataHandler, DataHelperConnectStatusDelegate, DataHelperServerInfoDelegate {
    
    static let ALIVE_TIMESPAN:TimeInterval = 25 //保活时间间隔
    var loginDataHelper: DataHelper!
    var quoteDataHelper: DataHelper!
    var tradeDateHelper: DataHelper!
    
    weak var delegate : DataManagerDelegate!
    weak var postDelegate: DataManagerPostNotificationDelegate!
    var isSuspended: Bool = false
    
    //保存server 返回数据
    //创建一个队列专门处理写入 读出数据
    let queue = DispatchQueue(label: "com.fdt.dataQueue",attributes:.concurrent)
//    let queue = DispatchQueue(label: "com.fdt.dataQueue")

    var marketStatueDic: [String:[String: Int]] = [:]
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
                                    connectionStage: .byServerLoc)
            self.loginDataHelper.dataAES_IV = "8765432112345678".data(using: String.Encoding.utf8)
        } else {
            FDTLog.logInfo("登录连接失败")
        }
        
        if let ip = self.dh_getServerHostSender(quoteDataHelper),
            let port = self.dh_getServerPortSender(quoteDataHelper){
            self.quoteDataHelper.connect(toRTServer: ip,
                                         onPort: Int32(port)!,
                                         connectionStage: .byServerLoc)
            self.loginDataHelper.dataAES_IV = "8765432112345678".data(using: String.Encoding.utf8)
        } else {
            FDTLog.logInfo("行情连接失败")
        }
        
        if let ip = self.dh_getServerHostSender(tradeDateHelper),
            let port = self.dh_getServerPortSender(tradeDateHelper){
            self.tradeDateHelper.connect(toRTServer: ip,
                                         onPort: Int32(port)!,
                                         connectionStage: .byServerLoc)
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
        } else if timer == loginDataHelper.timerAlive {
            loginDataHelper.nAliveCheck += 1
            if loginDataHelper.nAliveCheck > 1 {
                loginDataHelper.disConnectRT(withKeepRunning: true, resetHost: false)
            } else {
                loginDataHelper.doAlive()
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
    
    func startAliveForSender(_ sender: DataHelper?) {
        if let dataHelper = sender {
            dataHelper.nAliveCheck = 0
            DispatchQueue.main.async {
                dataHelper.timerAlive?.invalidate()
                dataHelper.timerAlive = nil
                dataHelper.timerAlive = Timer.scheduledTimer(timeInterval: DataManager.ALIVE_TIMESPAN, target: self, selector: #selector(self.doAliveForSender(_:)), userInfo: nil, repeats: true)
            }
        } else {
            //行情、交易、登录
            self.quoteDataHelper.nAliveCheck = 0
            self.tradeDateHelper.nAliveCheck = 0
            self.loginDataHelper.nAliveCheck = 0
            DispatchQueue.main.async {
                self.quoteDataHelper.timerAlive?.invalidate()
                self.quoteDataHelper.timerAlive = nil
                self.quoteDataHelper.timerAlive = Timer.scheduledTimer(timeInterval: DataManager.ALIVE_TIMESPAN, target: self, selector: #selector(self.doAliveForSender(_:)), userInfo: nil, repeats: true)
                
                self.tradeDateHelper.timerAlive?.invalidate()
                self.tradeDateHelper.timerAlive = nil
                self.tradeDateHelper.timerAlive = Timer.scheduledTimer(timeInterval: DataManager.ALIVE_TIMESPAN, target: self, selector: #selector(self.doAliveForSender(_:)), userInfo: nil, repeats: true)
                
                self.loginDataHelper.timerAlive?.invalidate()
                self.loginDataHelper.timerAlive = nil
                self.loginDataHelper.timerAlive = Timer.scheduledTimer(timeInterval: DataManager.ALIVE_TIMESPAN, target: self, selector: #selector(self.doAliveForSender(_:)), userInfo: nil, repeats: true)
            }
        }
    }
    
    func stopAliveForSender(_ sender: DataHelper?) {
        if let dataHelper = sender {
            DispatchQueue.main.async {
                dataHelper.timerAlive?.invalidate()
                dataHelper.timerAlive = nil
            }
        } else {
            DispatchQueue.main.async {
                self.quoteDataHelper.timerAlive?.invalidate()
                self.quoteDataHelper.timerAlive = nil
                
                self.tradeDateHelper.timerAlive?.invalidate()
                self.tradeDateHelper.timerAlive = nil
                
                self.loginDataHelper.timerAlive?.invalidate()
                self.loginDataHelper.timerAlive = nil
            }
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
        loginDataHelper.delegateDataHelperConnect = self
        loginDataHelper.dataHelperServerInfoDelegate = self
        
        //行情连线
        quoteDataHelper = DataHelper(dataMgr: self)
        quoteDataHelper.delegateDataHelperConnect = self
        quoteDataHelper.dataHelperServerInfoDelegate = self
        
        //交易连线
        tradeDateHelper = DataHelper(dataMgr: self)
        tradeDateHelper.delegateDataHelperConnect = self
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
        case .symbolStatus:
            //
            break
        case .connectChallenge:
            self.handleConnectChallenge(packet, sender: sender)
        case .encrypt:
            if sender == loginDataHelper {
                if let unPackPacket = sender.unpackEncryptPacket(packet) {
                    self.handleJPacket(unPackPacket, sender:sender)
                }
            } else {
                self.handleEncryptPacket(packet, sender: sender)
            }
        case .connectStatus:
            self.startAliveForSender(sender)
            self.handleConnectStatus(packet, sender: sender)
        case .alive:
            fallthrough
        case .aliveStatus:
            self.handleAliveStatus(packet,sender: sender)
        case .marketStatusUpdate:
            self.handleMarketStatus(packet)
        case .wmQuoteAndRankUpdate:
            self.handleWmQuoteAndRankUpdate(packet)
        default:
            FDTLog.logDebug("\(packet.pt.rawValue) \(packet.classForCoder) 没有实现")
        }
    }
    
    func handleJPacketTimeout(_ packet: JPacketSendBase?, sender: DataHelper) {
        if let pkt = packet {
            FDTLog.logInfo("发送数据包(\(pkt.pt))超时")
        } else {
            FDTLog.logInfo("发送数据包(未知)超时")
        }
        
    }
    
    
    //MARK DataHelperConnectStatusDelegate
    func handleConnect(_ status: Network_Status, obj: Any!, sender: DataHelper) {
        switch status {
        case .status_Connected:
            if sender == loginDataHelper {
                FDTLog.logDebug("登录连接成功")
            } else if sender == quoteDataHelper {
                FDTLog.logDebug("行情连接成功")
            } else if sender == tradeDateHelper {
                FDTLog.logDebug("交易连接成功")
            } else {
                FDTLog.logDebug("未知连接")
            }
            self.doAuthConnect(sender)
            break
        case .status_Connected:
            // Stop Heartbeat
            self.stopAliveForSender(sender)
            
        default:
            break
        }
    }

    func handleDisconnectedSender(_ sender: DataHelper) {
        //断开连接
        if sender == loginDataHelper {
            FDTLog.logDebug("登录断线")
        } else if sender == quoteDataHelper {
            FDTLog.logDebug("行情断线")
        } else if sender == tradeDateHelper {
            FDTLog.logDebug("交易断线")
        } else {
            FDTLog.logDebug("未知断线")
        }
    }
    
}
