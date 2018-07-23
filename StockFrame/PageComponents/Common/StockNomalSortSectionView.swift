//
//  StockNomalSortSectionView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

protocol StockNomalSortSectionProtocol: NSObjectProtocol {
    func lastSortAction()
}

class StockNomalSortSectionView: BaseView {
    
    weak var delegate: StockNomalSortSectionProtocol?
    
    var bottomView = BaseView()
    var nameLab = BaseLabel.LabelTextAlignmentLeft()
    
//    var priceView = BaseView()
    var priceLab = BaseLabel.LabelTextAlignmentRight()
    
    var lastView = BaseView()
    var lastLab = BaseLabel.LabelTextAlignmentRight()
    var lastImage = UIImageView()
    
    var titles = [String]()
    var sort: FDTSortType!
    var none = false
    
    init(titles:[String], sort:FDTSortType ,none: Bool = false) {
        super.init(frame: CGRect.zero)
        self.titles = titles
        self.sort = sort
        self.none = none
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func lastSortAction(_ sender: Any) {
        lastImage.isHighlighted = !lastImage.isHighlighted
        delegate?.lastSortAction()
    }
    
    // MARK: init
    func initView() {
        
        nameLab.font = UIFont.pingFangSCRegularFontOfSize(12)
        nameLab.textColor = UIColor.init(wmColor: FDTWMColor.marketCloseColor)
        nameLab.text =  titles[0]
        
        priceLab.font = UIFont.pingFangSCRegularFontOfSize(12)
        priceLab.textColor = UIColor.init(wmColor: FDTWMColor.marketCloseColor)
        priceLab.text = titles[1]
        
        lastLab.font = UIFont.pingFangSCRegularFontOfSize(12)
        lastLab.textColor = UIColor.init(wmColor: FDTWMColor.marketCloseColor)
        lastLab.text =  titles[2]
        
        if sort == .descending {
            lastImage.image = UIImage.Asset.Sort_arrowbottom.image
        } else {
            lastImage.image = UIImage.Asset.Sort_arrowtop.image
        }
        
        lastView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lastSortAction(_:))))
        
        let _ = lastView + [lastLab, lastImage]
        let _ = bottomView + [nameLab, priceLab, lastView]
        let _ = bottomView.addBottomLine()
        let _ = self + bottomView
    }
    
    override func updateConstraints()
    {
        bottomView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.top.bottom.centerY.equalTo(self)
            make.left.equalTo(self).offset(Layout.ui.regularOffsetX)
            make.width.equalToSuperview().multipliedBy(0.3333).offset(-Layout.ui.regularOffsetX)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.top.bottom.centerY.equalTo(self)
            make.left.equalTo(nameLab.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3333)
        }
        
        lastView.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right)
            make.top.bottom.centerY.equalTo(self)
            make.width.equalToSuperview().multipliedBy(0.3333).offset(-Layout.ui.regularOffsetX)
        }
        
        lastImage.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(lastView)
            make.width.height.equalTo(12)
        }
        
        
        lastLab.snp.makeConstraints { (make) in
            make.right.equalTo(lastImage.snp.left).offset(-Layout.ui.regularColumnOffsetX)
            make.top.bottom.centerY.equalTo(lastView)
        }
        
        super.updateConstraints()
    }
}
