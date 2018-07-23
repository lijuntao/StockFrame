//
//  StockNomalTableViewCell.swift
//  StockFrame
//
//  Created by fdt on 2018/7/20.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockNomalTableViewCell: BaseTableViewCell {

    var symbolLab = BaseLabel.LabelTextAlignmentLeft()
    var symbol2Lab = BaseLabel.LabelTextAlignmentLeft()
    var symbolMarketLab = BaseLabel.LabelTextAlignmentCenter()
    var lastLab = BaseLabel.LabelTextAlignmentRight()
    //最后一列数据
    var rightLab = BaseLabel.LabelTextAlignmentRight()
    
    var separatorLine = BaseView()
    var bottomView  = BaseView()
    var symbolView = BaseView()
    var marketView = BaseView()
    static let CELL_ID: String = "StockNomalTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
    }
    
    func setDataFromViewModel(_ viewModel: StockRankCellViewModel) {
        self.symbolLab.text = viewModel.symbolName
        self.symbol2Lab.text = viewModel.symbolName2
        self.symbolMarketLab.text = viewModel.symbolMarket
        self.symbolMarketLab.textColor = viewModel.symbolMarketColor
        self.symbolMarketLab.layer.backgroundColor = viewModel.symbolMarketBGColor.cgColor
        self.lastLab.text = viewModel.last
        self.lastLab.textColor = viewModel.lastColor
        if viewModel.isAmtItem() {
            self.rightLab.attributedText = viewModel.totalValue
        } else {
            self.rightLab.text = viewModel.chgP
            self.rightLab.textColor = viewModel.changeColor
        }
    }

    // MARK: Private Method
    /**
     初始化頁面元件
     */
    fileprivate func initView() -> Void
    {
        self.contentView.clipsToBounds = true
        
        let _ = symbolView + symbolLab
        let _ = marketView + [symbolMarketLab, symbol2Lab]
        let _ = bottomView + [symbolView, marketView, lastLab, rightLab, separatorLine]
        let _ = self.contentView + [bottomView]
        
        symbolLab.font = UIFont.pingFangSCRegularFontOfSize(18)
        symbolLab.textColor = UIColor(wmColor: FDTWMColor.mainTextColor)
        
        symbolMarketLab.font = UIFont.pingFangSCRegularFontOfSize(9)
        symbolMarketLab.textColor = UIColor(wmColor: FDTWMColor.whiteColor)
        symbolMarketLab.clipsToBounds = true
        
        symbol2Lab.font = UIFont.dinRegularFontOfSize(11)
        symbol2Lab.textColor = FDTWMColor.marketCloseColor.color
        
        lastLab.font = UIFont.dinRegularFontOfSize(22)
        lastLab.textColor = UIColor(wmColor: FDTWMColor.mainTextColor)
        
        rightLab.font = UIFont.dinRegularFontOfSize(22)
        rightLab.textColor = UIColor(wmColor: FDTWMColor.mainTextColor)
     
        separatorLine.backgroundColor = UIColor(wmColor: FDTWMColor.backgroundColor)
    }
    
    override func updateConstraints() {
        bottomView.snp.updateConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        symbolView.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
            make.width.equalToSuperview().multipliedBy(0.3333)
        }
        
        symbolLab.snp.updateConstraints { (make) in
            make.right.centerY.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Layout.ui.regularOffsetX)
        }
        
        marketView.snp.updateConstraints { (make) in
            make.bottom.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
            make.width.equalToSuperview().multipliedBy(0.3333)
        }
        
        symbolMarketLab.snp.updateConstraints { (make) in
//            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Layout.ui.regularOffsetX)
            make.top.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(11)
        }
        
        symbol2Lab.snp.updateConstraints { (make) in
            make.left.equalTo(symbolMarketLab.snp.right).offset(Layout.ui.regularColumnOffsetX)
            make.top.equalToSuperview()
            make.height.equalTo(11)
            make.width.equalToSuperview().offset(-(20 + Layout.ui.regularOffsetX + Layout.ui.regularColumnOffsetX))
        }
        
        lastLab.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(symbolView.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3333)
        }
        
        rightLab.snp.updateConstraints { (make) in
            make.right.equalToSuperview().offset(-Layout.ui.regularOffsetX)
            make.top.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3333).offset(-Layout.ui.regularOffsetX)
        }
        
        separatorLine.snp.updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
        }
        super.updateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
