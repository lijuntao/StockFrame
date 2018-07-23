//
//  StockAHTableViewCell.swift
//  StockFrame
//
//  Created by fdt on 2018/7/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockAHTableViewCell: BaseTableViewCell {

    static let CELL_ID: String = "StockAHTableViewCell"
    
    var bottomView = BaseView()
    var symbolView = BaseView()
    var marketView = BaseView()
    var aLastPriceView = BaseView()
    var aLastRationView = BaseView()
    var hLastPriceView = BaseView()
    var hLastRationView = BaseView()
    
    var symbolLab = BaseLabel.LabelTextAlignmentLeft()
    var symbol2Lab = BaseLabel.LabelTextAlignmentLeft()
    var symbolMarketLab = BaseLabel.LabelTextAlignmentCenter()
    var hLastPriceLab = BaseLabel.LabelTextAlignmentCenter()
    var hLastRatioLab = BaseLabel.LabelTextAlignmentCenter()
    var aLastPriceLab = BaseLabel.LabelTextAlignmentCenter()
    var aLastRatioLab = BaseLabel.LabelTextAlignmentCenter()
    var premiumLab = BaseLabel.LabelTextAlignmentRight()
    
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
    
    func setDataFromViewModel(_ viewModel: StockRankAHCellViewModel) {
        self.symbolLab.text = viewModel.symbolName
        self.symbol2Lab.text = viewModel.symbolName2
        self.symbolMarketLab.text = viewModel.symbolMarket
        self.symbolMarketLab.textColor = viewModel.symbolMarketColor
        self.symbolMarketLab.layer.backgroundColor = viewModel.symbolMarketBGColor.cgColor
        self.hLastPriceLab.text = viewModel.hLastPrice
        self.hLastPriceLab.textColor = viewModel.hLastColor
        self.hLastRatioLab.text = viewModel.hLastRatio
        self.hLastRatioLab.textColor = viewModel.hLastColor
        self.aLastPriceLab.text = viewModel.aLastPrice
        self.aLastPriceLab.textColor = viewModel.aLastColor
        self.aLastRatioLab.text = viewModel.aLastRatio
        self.aLastRatioLab.textColor = viewModel.aLastColor
        self.premiumLab.text = viewModel.premium
        self.premiumLab.textColor = viewModel.premiumColor
    }
    
    /// 初始化界面
    fileprivate func initView() -> Void
    {
        
        self.contentView.clipsToBounds = true
        
        symbolLab.font = UIFont.pingFangSCRegularFontOfSize(16)
        symbolLab.textColor = UIColor(wmColor: FDTWMColor.mainTextColor)
        
        symbolMarketLab.font = UIFont.pingFangSCRegularFontOfSize(9)
        symbolMarketLab.textColor = UIColor(wmColor: FDTWMColor.whiteColor)
        symbolMarketLab.clipsToBounds = true
        
        symbol2Lab.font = UIFont.dinRegularFontOfSize(11)
        symbol2Lab.textColor = FDTWMColor.marketCloseColor.color
        
        hLastPriceLab.font = UIFont.dinRegularFontOfSize(14)
        hLastPriceLab.textColor = FDTWMColor.marketCloseColor.color
        
        hLastRatioLab.font = UIFont.dinRegularFontOfSize(14)
        hLastRatioLab.textColor = FDTWMColor.marketCloseColor.color
        
        aLastPriceLab.font = UIFont.dinRegularFontOfSize(14)
        aLastPriceLab.textColor = FDTWMColor.marketCloseColor.color
        
        aLastRatioLab.font = UIFont.dinRegularFontOfSize(14)
        aLastRatioLab.textColor = FDTWMColor.marketCloseColor.color
        
        premiumLab.font = UIFont.dinRegularFontOfSize(19)
        premiumLab.textColor = FDTWMColor.marketCloseColor.color
        
        let _ = symbolView + symbolLab
        let _ = marketView + [symbolMarketLab, symbol2Lab]
        let _ = aLastPriceView + aLastPriceLab
        let _ = aLastRationView + aLastRatioLab
        let _ = hLastPriceView + hLastPriceLab
        let _ = hLastRationView + hLastRatioLab
        let _ = bottomView + [symbolView, marketView, hLastPriceView, hLastRationView, aLastPriceView, aLastRationView, premiumLab]
        let _ = bottomView.addBottomLine()
        let _ = self.contentView + [bottomView]
    }
    
    
    override func updateConstraints() {
        bottomView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        symbolView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        symbolLab.snp.makeConstraints { (make) in
            make.right.centerY.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Layout.ui.regularOffsetX)
        }
        
        marketView.snp.makeConstraints { (make) in
            make.bottom.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        symbolMarketLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Layout.ui.regularOffsetX)
            make.top.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(11)
        }
        
        symbol2Lab.snp.makeConstraints { (make) in
            make.left.equalTo(symbolMarketLab.snp.right).offset(Layout.ui.regularColumnOffsetX)
            make.top.equalToSuperview()
            make.height.equalTo(11)
            make.width.equalToSuperview().offset(-(20 + Layout.ui.regularOffsetX + Layout.ui.regularColumnOffsetX))
        }
        
        hLastPriceView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(symbolView.snp.right)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        hLastRationView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(symbolView.snp.right)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        hLastPriceLab.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        hLastRatioLab.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        aLastPriceView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(hLastPriceView.snp.right)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        aLastRationView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(hLastPriceView.snp.right)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        aLastPriceLab.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        aLastRatioLab.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        premiumLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-Layout.ui.regularOffsetX)
            make.top.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3333).offset(-Layout.ui.regularOffsetX)
        }
        
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
