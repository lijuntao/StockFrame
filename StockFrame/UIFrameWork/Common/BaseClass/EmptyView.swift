//
//  EmptyView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

class StockEmptyView: BaseView
{
    static let VIEW_HEIHGT: CGFloat = 118
    
    fileprivate let image_width: CGFloat = 48.0
    fileprivate let offset_top: CGFloat =  25.0
    
    var imageView: UIImageView! = UIImageView(image: UIImage.Asset.Market_empty.image)
    var titleLabel: BaseLabel.LabelTextAlignmentCenter! = BaseLabel.LabelTextAlignmentCenter()
    
    init() {
        super.init(frame: CGRect.zero)
        
        titleLabel.font = UIFont.pingFangSCRegularFontOfSize(12)
        titleLabel.textColor = FDTWMColor.defalueTextColor.color
        titleLabel.text = L10n.stockMarketOpensoon.string
        self.backgroundColor = UIColor.white
        let _ = self + [imageView, titleLabel]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints()
    {
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(offset_top)
            make.width.height.equalTo(image_width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(13)
        }
        
        super.updateConstraints()
    }
    
}

class OptionalStockEmptyView: BaseView
{
    fileprivate let image_width: CGFloat = 100.0
    fileprivate let offset_top: CGFloat = -100.0
    var imageView: UIImageView! = UIImageView(image: UIImage.Asset.Optional_no_add.image)
    var titleLabel: BaseLabel.LabelTextAlignmentCenter! = BaseLabel.LabelTextAlignmentCenter()
    
    init() {
        super.init(frame: CGRect.zero)
        
        titleLabel.font = UIFont.pingFangSCRegularFontOfSize(15)
        titleLabel.textColor = FDTWMColor.defalueTextColor.color
        titleLabel.text = L10n.clickToAddAStock.string
        self.backgroundColor = UIColor.white
        let _ = self + [imageView, titleLabel]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints()
    {
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(offset_top)
            make.width.height.equalTo(image_width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        super.updateConstraints()
    }
    
}

class SearchStockEmptyView: BaseView
{
    fileprivate let image_width: CGFloat = 100.0
    fileprivate let offset_top: CGFloat = -100.0
    var imageView: UIImageView! = UIImageView(image: UIImage.Asset.Market_empty.image)
    var titleLabel: BaseLabel.LabelTextAlignmentCenter! = BaseLabel.LabelTextAlignmentCenter()
    
    init() {
        super.init(frame: CGRect.zero)
        
        titleLabel.font = UIFont.pingFangSCRegularFontOfSize(15)
        titleLabel.textColor = FDTWMColor.defalueTextColor.color
        titleLabel.text = L10n.noQueryResults.string
        self.backgroundColor = UIColor.white
        let _ = self + [imageView, titleLabel]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints()
    {
        super.updateConstraints()
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(offset_top)
            make.width.height.equalTo(image_width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
    }
    
}
