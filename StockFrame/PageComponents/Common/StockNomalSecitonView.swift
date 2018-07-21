//
//  StockNomalSecitonView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/21.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

enum NomalSectionViewStyle {
    case normal
    case toast
}

protocol NomalSectionViewProtocol: NSObjectProtocol {
    func tapFoldedSection(_ section: Int)
    func moreButtonSection(_ section: Int)
    func toastButtonSection(_ section: Int)
}

class StockNomalSecitonView: BaseView {

    weak var delegate: NomalSectionViewProtocol?
    var bottomView: BaseView!
    var titleLable: BaseLabel!
    var foldImageView: UIImageView!
    var moreButton: BaseButton!
    var toastButtom: BaseButton!
    var folded: Bool!
    var title:String!
    var style:NomalSectionViewStyle!
    var section: Int!
    init(title: String, style: NomalSectionViewStyle, folded: Bool = false,section: Int = 0) {
        super.init(frame: CGRect.zero)
        self.title = title
        self.style = style
        self.folded = folded
        self.section = section
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapFoldedAction(_ sender: Any) {
        delegate?.tapFoldedSection(self.section)
    }
    
    @objc func moreButtonAction(_ sender: Any) {
        delegate?.moreButtonSection(self.section)
    }
    
    @objc func toastButtonAction(_ sender: Any) {
        delegate?.toastButtonSection(self.section)
    }
    
    // MARK: private
    func initView() {
        bottomView = BaseView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFoldedAction(_:)))
        bottomView.addGestureRecognizer(tapGesture)
        
        titleLable = BaseLabel.LabelTextAlignmentLeft()
        titleLable.text = title
        titleLable.font = UIFont.pingFangSCRegularFontOfSize(14)
        titleLable.textColor = FDTWMColor.marketCloseColor.color
        
        foldImageView = UIImageView(image: UIImage.Asset.List_left.image.tint(color: FDTWMColor.marketCloseColor.color))
        if !folded {
            foldImageView.transform =  self.foldImageView.transform.rotated(by: CGFloat(Double.pi * 0.5))
        }
        
        moreButton = BaseButton(type: .custom)
        moreButton.setImage(UIImage.Asset.More_dot.image, for: .normal)
        moreButton.addTarget(self, action: #selector(moreButtonAction(_:)), for: .touchUpInside)
        
        toastButtom = BaseButton(type: .custom)
        toastButtom.setImage(UIImage.Asset.Toast.image, for: .normal)
        toastButtom.addTarget(self, action: #selector(toastButtonAction(_:)), for: .touchUpInside)
        if style == .normal{
            toastButtom.isHidden = true
        }
        
        let _ = bottomView + [foldImageView, titleLable, toastButtom, moreButton]
        let _ = bottomView.addBottomLine()
        let _ = self + bottomView
    }
    
    override func updateConstraints() {
        
        bottomView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        foldImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Layout.ui.regularOffsetX)
            make.centerY.equalToSuperview()
        }
        
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(foldImageView.snp.right).offset(Layout.ui.regularColumnOffsetX)
            make.centerY.equalToSuperview()
        }
        
        toastButtom.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.right).offset(Layout.ui.regularColumnOffsetX)
            make.centerY.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.bottom.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-Layout.ui.regularOffsetX)
        }
        
        super.updateConstraints()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
