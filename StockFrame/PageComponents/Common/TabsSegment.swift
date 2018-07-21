//
//  TabsSegment.swift
//  StockFrame
//
//  Created by fdt on 2018/7/21.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class TabsSegmentConfig {
    var font = UIFont.pingFangSCRegularFontOfSize(14)
    var defaultTextColor = FDTWMColor.marketCloseColor.color
    var activeTextColor = FDTWMColor.mainTextColor.color
    var sliderColor = FDTWMColor.activeColor.color
    var sliderHeight = 2
    
    init() {
    }
}

protocol TabsSegmentProtocol: NSObjectProtocol {
    func tabsActiveIndex(_ index: Int)
}

class TabsSegment: BaseView {

    weak var delegate: TabsSegmentProtocol?
    let BTN_TAG_START = 3000 //button tag 起始索引
    var btns = [BaseButton]()
    var slider = BaseView()
    var bottomView = BaseView()
    var separatorLine = BaseView()
    var config = TabsSegmentConfig()
    var tabs = [String]()
    var activeIndex = 0 //当前激活btn
    init(tabs:[String], config: TabsSegmentConfig = TabsSegmentConfig(), activeIndex: Int = 0) {
        super.init(frame: CGRect.zero)
        self.tabs = tabs
        self.config = config
        self.activeIndex = activeIndex
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        slider.backgroundColor = config.sliderColor
        separatorLine.backgroundColor = UIColor(wmColor: FDTWMColor.backgroundColor)
        for (index, title) in tabs.enumerated() {
            let btn = BaseButton.init(frame: CGRect.zero)
            btn.tag = BTN_TAG_START + index
            btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(config.defaultTextColor, for: .normal)
            btn.setTitleColor(config.activeTextColor, for: .highlighted)
            btn.setTitleColor(config.activeTextColor, for: .selected)
            btn.titleLabel?.font = config.font
            if index == activeIndex {
                btn.isSelected = true
            }
            btns.append(btn)
            let _ = bottomView + btn
        }
        
        let _ = bottomView + slider
        let _ = self + bottomView
        let _ = self + separatorLine
    }
    
    override func updateConstraints() {
        bottomView.snp.remakeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        var preBtn = btns.first!
        for (index, btn) in btns.enumerated() {
            if index == 0 {
                btn.snp.remakeConstraints { (make) in
                    make.top.bottom.equalToSuperview()
                    make.width.equalToSuperview().dividedBy(btns.count)
                    make.left.equalToSuperview()
                }
            } else {
                btn.snp.remakeConstraints { (make) in
                    make.top.bottom.equalToSuperview()
                    make.width.equalToSuperview().dividedBy(btns.count)
                    make.left.equalTo(preBtn.snp.right)
                }
            }
            preBtn = btn
        }
        
        let activeBtn = btns[activeIndex]
        slider.snp.remakeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(config.sliderHeight)
            make.width.equalTo(activeBtn)
            make.left.equalTo(activeBtn)
        }
        
        separatorLine.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
        }
        
        super.updateConstraints()
    }
    
    @objc func buttonAction(_ sender: Any) {
        let btn = sender as! BaseButton
        let tag = btn.tag
        for item in btns {
            print(item.tag)
            if item.tag == tag {
                item.isSelected = true
                activeIndex = tag - BTN_TAG_START
            } else {
                item.isSelected = false
            }
        }
        if let target = delegate {
            target.tabsActiveIndex(tag - BTN_TAG_START)
        } else {
            FDTLog.logDebug("代理未实现")
        }
        self.setNeedsUpdateConstraints()
    }
    
    func setBtnActionIndex(_ index: Int) {
        for view in self.bottomView.subviews {
            if let button = view as? UIButton {
                if (button.tag - BTN_TAG_START) == index {
                    self.buttonAction(button)
                    break
                }
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
