//
//  FDTRefreshControlViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/11.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

protocol FDTRefreshControlProtocol: NSObjectProtocol {
    func start() -> Void
    func stop() -> Void
}

class FDTRefreshControl: BaseView, FDTRefreshControlProtocol {
    var button = UIButton(type: UIButtonType.custom)
    var indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var imageSize: CGFloat = 22
    var indicatorOffset: CGFloat = 0
    var viewModel: FDTRefreshControlViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = FDTWMColor.navigationColor.color
        indicator.isHidden = true
        button.setImage(UIImage.Asset.Nav_refresh.image, for: .normal)
        button.addTarget(self, action: #selector(startProcess(_:)), for: .touchUpInside)
        
        self.clipsToBounds = true
        let _ = self + [indicator, button]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Public Method
    
    /// 设置指示器type
    ///
    /// - Parameter type: UIActivityIndicatorViewStyle
    func setIndicatorType(_ type:UIActivityIndicatorViewStyle){
        self.indicator.activityIndicatorViewStyle = type;
    }
    
    func setImage(_ image: UIImage) {
        self.button.setImage(image, for: .normal)
    }
    
    //MARK:
    
    /// 开始刷新
    ///
    /// - Parameter sender: sender
    @objc func startProcess(_ sender:Any?) {
        self.viewModel.stopCounting()
        if let closure = self.viewModel.processClosure
        {
            button.isHidden = true
            indicator.isHidden = false
            indicator.startAnimating()
            if let _ = sender {
                closure(true)
            }else{
                closure(false)
            }
        }
        if self.viewModel.countingMode {
            self.viewModel.startCounting()
        }
    }
    
    
    /// 停止
    func stopProcess() {
        indicator.stopAnimating()
        indicator.isHidden = true
        button.isHidden = false
    }
    
    func bindViewModel(_ vm: FDTRefreshControlViewModel) {
        self.viewModel = vm
        self.viewModel.delegateRefresh = self
    }
    
    //MARK: FDTRefreshControlProtocol
    func start() {
        self.startProcess(nil)
    }
    
    func stop() {
        self.stopProcess()
    }
    
    override func updateConstraints() {
        
        indicator.snp.updateConstraints { (make) in
            make.width.height.equalTo(32)
            make.left.top.equalTo(self)
        }
        
        button.snp.updateConstraints { (make) in
            make.width.height.equalTo(32)
            make.left.top.equalTo(self)
        }
        
        super.updateConstraints()
    }
}


class FDTRefreshControlViewModel: BaseViewModel {
    
    
    weak var delegateRefresh: FDTRefreshControlProtocol?
    
    fileprivate var timer: Timer?
    
    var countingMode: Bool = true
    var countingTime: TimeInterval = 3
    
    var processClosure:((_ manul: Bool)->())?
    
    @objc func startProcess(_ sender: Any?) {
        delegateRefresh?.start()
    }
    
    func stopProcess() {
        delegateRefresh?.stop()
    }
    
    /**
     start counting
     */
    func startCounting() {
        if timer == nil {
//            timer = Timer.scheduledTimer(timeInterval: countingTime, target: self, selector: #selector(startProcess(_:)), userInfo: nil, repeats: false)
            timer = Timer.scheduledTimer(withTimeInterval: countingTime, repeats: false, block: { [weak self] _ in
                self?.startProcess(nil)
            })
        }else {
            timer?.invalidate()
//            timer = Timer.scheduledTimer(timeInterval: countingTime, target: self, selector: #selector(startProcess(_:)), userInfo: nil, repeats: false)
            timer = Timer.scheduledTimer(withTimeInterval: countingTime, repeats: false, block: { [weak self](_) in
                self?.startProcess(nil)
            })
        }
    }
    
    /**
     stop counting
     */
    func stopCounting() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 重置
    func reset() {
        self.setCountingMode(false)
        self.stopProcess()
        self.stopCounting()
        processClosure = nil
    }
    
    // MARK: Setter
    func setProcess(_ closure: @escaping (Bool) -> ()) {
        processClosure = closure
    }
    
    func setCountingMode(_ counting: Bool) {
        countingMode = counting
    }
    
    func setTimeInterval(_ time: TimeInterval) {
        countingTime = time
    }
}
