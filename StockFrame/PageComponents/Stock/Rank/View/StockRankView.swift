//
//  StockRankView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankView: BaseView, UITableViewDataSource, UITableViewDelegate, ViewModelProtocol, NomalSectionViewProtocol {

    var viewModel: StockRankViewModel!
    
    var tableView: UITableView!
    var emptyView: StockEmptyView!
    
    init(frame: CGRect, viewModel: StockRankViewModel) {
        super.init(frame: frame)
        self.viewModel = viewModel
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
        tableView.register(StockSimpleTableViewCell.classForCoder(), forCellReuseIdentifier: StockSimpleTableViewCell.CELL_ID)
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
    
    // MARK: NomalSectionViewProtocol
    func tapFoldedSection(_ section: Int) {
        self.viewModel.setSectionFolded(section)
        UIView.setAnimationsEnabled(false)
        self.tableView.beginUpdates()
        tableView.reloadSections([section], with: .none)
        self.tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func moreButtonSection(_ section: Int) {
        FDTLog.logInfo("更多")
        let params = [TITLE_KEY:self.viewModel.getSectionTitle(section),
                      MARKET_KEY: self.viewModel.getSectionMarketType(section),
                      CATEGORY_KEY: self.viewModel.getSectionCatagary(section)] as [String : Any]
        FDT_UI_Public_Proxy.GoToVCWithId(PAGE_ID_STOCK_MORE_RANK, params: params)
    }
    
    func toastButtonSection(_ section: Int) {
        FDTLog.logInfo("toast")
    }

    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCellCount(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.viewModel.getCellType(indexPath.section)
        switch cellType {
        case .simple:
            let cell = tableView.dequeueReusableCell(withIdentifier: StockSimpleTableViewCell.CELL_ID) as! StockSimpleTableViewCell
            let vm = self.viewModel.getCellViewModel(indexPath.section, row: indexPath.row) as! StockRankCellViewModel
            cell.setDataFromViewModel(vm)
            cell.selectionStyle = .gray
            return cell
        case .normal:
            let cell = tableView.dequeueReusableCell(withIdentifier: StockNomalTableViewCell.CELL_ID) as! StockNomalTableViewCell
            let vm = self.viewModel.getCellViewModel(indexPath.section, row: indexPath.row) as! StockRankCellViewModel
            cell.setDataFromViewModel(vm)
            cell.selectionStyle = .gray
            return cell
        case .ah:
            let cell = tableView.dequeueReusableCell(withIdentifier: StockAHTableViewCell.CELL_ID) as! StockAHTableViewCell
            let vm = self.viewModel.getCellViewModel(indexPath.section, row: indexPath.row) as! StockRankAHCellViewModel
            cell.setDataFromViewModel(vm)
            cell.selectionStyle = .gray
            return cell
        }
        
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = StockNomalSecitonView(title: self.viewModel.getSectionTitle(section),
                                               style: self.viewModel.getSectionViewStyle(section),
                                               folded: self.viewModel.getSectionFolded(section),
                                               section: section)
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Layout.ui.regularSectionHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.ui.regularCellHeight
    }
    
}
