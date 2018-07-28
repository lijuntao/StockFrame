//
//  ChartConfig.swift
//  StockFrame
//
//  Created by fdt on 2018/7/26.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

//分时图是否显示指标区域
let CHART_TIMELINE_SHOW_INDEX = true
//指标框比例
let CHART_INDEX_RATIO: CGFloat = CHART_TIMELINE_SHOW_INDEX ? 0.3 : 0.0
//上边距
let CHART_TOP_GAP: CGFloat = 5.0
//下边距
let CHART_BOTTOM_GAP: CGFloat = CHART_TIMELINE_SHOW_INDEX ? 5.0 : 0.0
//上下边距
let CHART_TOP_BOTTOM_GAP = CHART_TOP_GAP + CHART_BOTTOM_GAP
//左边距
let CHART_LEFT_GAP: CGFloat = 5.0
//右边距
let CHART_RIGHT_GAP: CGFloat = 5.0
//左右边距
let CHART_LEFT_RIGHT_GAP = CHART_LEFT_GAP + CHART_RIGHT_GAP
//曲线与成交量间距
let CHART_SECTION_GAP: CGFloat = 20.0
//默认线宽
let CHART_LINE_DEFALUT_WIDTH: CGFloat = 1.0
//十字线宽
let CHART_LINE_CROSS_WIDTH: CGFloat = 0.5
