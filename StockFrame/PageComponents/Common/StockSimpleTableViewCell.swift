//
//  StockSimpleTableViewCell.swift
//  StockFrame
//
//  Created by fdt on 2018/7/20.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockSimpleTableViewCell: BaseTableViewCell {

    var symbolLab = BaseLabel.LabelTextAlignmentLeft()
    var lastLab = BaseLabel.LabelTextAlignmentRight()
    //最后一列数据
    var rightLab = BaseLabel.LabelTextAlignmentRight()
    
    var separatorLine = BaseView()
    var bottomView  = BaseView()
    var symbolView = BaseView()
    static let CELL_ID: String = "StockSimpleTableViewCell"
    
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
        self.lastLab.textColor = viewModel.lastColor
        self.rightLab.textColor = viewModel.changeColor
        if viewModel.isFXItem() {
            self.lastLab.attributedText = viewModel.lastAttr
            self.rightLab.attributedText = viewModel.chgAttr
        } else {
            self.lastLab.text = viewModel.last
            self.rightLab.text = viewModel.chgP
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
        let _ = bottomView + [symbolView, lastLab, rightLab, separatorLine]
        let _ = self.contentView + [bottomView]
        
        symbolLab.font = UIFont.pingFangSCRegularFontOfSize(20)
        symbolLab.textColor = UIColor(wmColor: FDTWMColor.mainTextColor)
        
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
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3333)
        }
        
        symbolLab.snp.updateConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalToSuperview().offset(Layout.ui.regularOffsetX)
        }
        
        
        lastLab.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(symbolView.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3333)
        }
        
        rightLab.snp.updateConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3333)
            make.right.equalToSuperview().offset(-Layout.ui.regularOffsetX)
        }
        
        separatorLine.snp.updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
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
