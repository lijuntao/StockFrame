//
//  StockRankMoreView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankMoreView: BaseView, UITableViewDataSource, UITableViewDelegate, ViewModelProtocol, StockNomalSortSectionProtocol {
    
    var viewModel: StockRankMoreViewModel!
    var tableView: UITableView!
    var emptyView: StockEmptyView!
    
    
    init(frame: CGRect, category: RankingCategory, marketType: MarketType) {
        super.init(frame: frame)
        self.viewModel = StockRankMoreViewModel(category: category, marketType: marketType)
        self.viewModel.delegate = self
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activeViewModel() {
        self.viewModel.active()
    }
    
    override func deactiveViewModel() {
        self.viewModel.deactive()
    }
    
    // MAKR: ViewModelProtocol
    func refreshUI() {
        emptyView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    // MARK: Private Method
    
    /// 初始化空态
    fileprivate func initView()
    {
        self.initTableView()
        self.initEmptyView()
    }
    
    /// 初始化TableView
    fileprivate func initEmptyView() {
        emptyView = StockEmptyView.init()
        
        let _ = self + emptyView
    }
    
    fileprivate func initTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.init(wmColor: FDTWMColor.backgroundColor)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isHidden = true
        
        tableView.register(StockNomalTableViewCell.classForCoder(), forCellReuseIdentifier: StockNomalTableViewCell.CELL_ID)
        tableView.register(StockAHTableViewCell.classForCoder(), forCellReuseIdentifier: StockAHTableViewCell.CELL_ID)
        
        let _ = self + tableView
    }
    
    override func updateConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.top.left.right.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { (make) in
            make.bottom.top.left.right.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    // MARK: StockNomalSortSectionProtocol
    func lastSortAction() {
        self.viewModel.sortBy()
        FDTLog.logDebug("最后一列点击")
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.viewModel.category
        if cellType == .AH {
            let cell = tableView.dequeueReusableCell(withIdentifier: StockAHTableViewCell.CELL_ID) as! StockAHTableViewCell
            let vm = self.viewModel.cellArray[indexPath.row] as! StockRankAHCellViewModel
            cell.setDataFromViewModel(vm)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StockNomalTableViewCell.CELL_ID) as! StockNomalTableViewCell
            let vm = self.viewModel.cellArray[indexPath.row] as! StockRankCellViewModel
            cell.setDataFromViewModel(vm)
            return cell
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = StockNomalSecitonView(title: self.viewModel.getSectionTitle(section),
//                                               style: self.viewModel.getSectionViewStyle(section),
//                                               folded: self.viewModel.getSectionFolded(section),
//                                               section: section)
//        headerView.delegate = self
        let headerView = StockNomalSortSectionView(titles: self.viewModel.getSectionTitles(),
                                                   sort: self.viewModel.getSortType())
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Layout.ui.regularSectionHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.ui.regularCellHeight
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
