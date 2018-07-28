//
//  ChartLineView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class ChartLineView: BaseView, ViewModelProtocol {

    var viewModel = ChartLineViewModel()
    var gradLayer: CAGradientLayer?
    var viewWidth: CGFloat = 0.0
    var viewHeight: CGFloat = 0.0
    var originPoint = CGPoint(x: CHART_LEFT_GAP, y: CHART_TOP_GAP)
    //下方成交量指标高度
    var indexChartHeight: CGFloat = 0.0
    var indexChartWidth: CGFloat = 0.0
    //上方绘图区域
    var lineChartHeight: CGFloat = 0.0
    var lineChartWidth: CGFloat = 0.0
    //x轴分度
    var unitX: CGFloat = 0.0
    var isLongPress = false
    var activeIndex: Int = 0
    var activeLocation = CGPoint.zero
    init(symbolId: String, period: EnumChartPeriod) {
        super.init(frame: CGRect.zero)
        viewModel =  ChartLineViewModel(symbolId: symbolId, period: period)
        viewModel.delegate = self
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction(_:)))
        self.addGestureRecognizer(longPress)
    }
    
    convenience override init(frame: CGRect) {
        self.init(symbolId: "000002.SZ.WM", period: .DC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activeViewModel() {
        viewModel.active()
    }
    
    override func deactiveViewModel() {
        viewModel.deactive()
    }
    
    @objc func longPressAction(_ sender: Any) {
        guard let longPressGes = sender as? UILongPressGestureRecognizer  else {
            return
        }
        let activeRect = CGRect(x: originPoint.x,
                                y: originPoint.y,
                                width: lineChartWidth,
                                height: lineChartHeight + indexChartHeight - CHART_SECTION_GAP)
        if longPressGes.state == .changed || longPressGes.state == .began {
            let location = longPressGes.location(in: self)
            self.activeLocation = location
            if self.viewModel.lineItems.count <= 0 {
                isLongPress = false
                self.setNeedsDisplay()
                return
            }
            isLongPress = true
            
            let realLoaction = CGPoint(x: location.x - CHART_LEFT_GAP, y: location.y - CHART_TOP_GAP)
            activeIndex = Int(ceil(realLoaction.x / (activeRect.size.width / CGFloat(self.viewModel.lineCount!))))
            if activeIndex <= 0 {
                activeIndex = 0
            } else if activeIndex >= self.viewModel.lineCount! - 1 {
                activeIndex = self.viewModel.lineCount! - 1
            }
        }
        
        if longPressGes.state == .ended ||
            longPressGes.state == .cancelled ||
            longPressGes.state == .failed {
            isLongPress = false
        }
        self.setNeedsDisplay()
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()!
        viewWidth = rect.size.width
        viewHeight = rect.size.height
        originPoint = CGPoint(x: CHART_LEFT_GAP, y: CHART_TOP_GAP)
        //下方成交量指标高度
        indexChartHeight = viewHeight * CHART_INDEX_RATIO
        indexChartWidth = viewWidth - CHART_LEFT_RIGHT_GAP
        //上方绘图区域
        lineChartHeight = viewHeight - CHART_TOP_BOTTOM_GAP - CHART_SECTION_GAP - indexChartHeight
        lineChartWidth = viewWidth - CHART_LEFT_RIGHT_GAP
        
        //绘制整体线框
        self.drawBox(context: context, rect: rect)
        
        //如果没有数据 直接返回 不绘制
        if self.viewModel.lineItems.count <= 0 {
            return
        }
        
        let lineCount = self.viewModel.lineCount!
        unitX = lineChartWidth / CGFloat(lineCount - 1)
        //绘制边框文字
        self.drawBoxText(context: context, rect: rect)
        //绘制线图
        self.drawLine(context: context, rect: rect)
    }
    
    //绘制均线
    func drawLine(context: CGContext, rect: CGRect) {
        if gradLayer != nil {
            gradLayer?.removeFromSuperlayer()
        }

        let lineItems = self.viewModel.lineItems
        var avgLinePoints = [CGPoint]()
        var priceLinePoints = [CGPoint]()
        var attr = [NSAttributedStringKey.font: UIFont.dinLightFontOfSize(14),
                    NSAttributedStringKey.foregroundColor: FDTWMColor.grayTextColor.color]
        let unitY = lineChartHeight / (self.viewModel.maxPrice - self.viewModel.minPrice)
        
        //曲线
        for (index, item) in lineItems.enumerated() {
            let avgPointX = CGFloat(index) * unitX + CHART_LEFT_GAP
            let avgPointY = originPoint.y + (self.viewModel.maxPrice - CGFloat(item.avgPX.floatValue)) * unitY
            let pricePointY = originPoint.y + (self.viewModel.maxPrice - CGFloat(item.close.floatValue)) * unitY
            avgLinePoints.append(CGPoint(x: avgPointX, y: avgPointY))
            priceLinePoints.append(CGPoint(x: avgPointX, y: pricePointY))
        }
        FDTChartDrawTools.drawLine(context: context, pointArray: priceLinePoints, lineWidth: CHART_LINE_DEFALUT_WIDTH, color: FDTWMColor.timeLineColor.color)
        FDTChartDrawTools.drawLine(context: context, pointArray: avgLinePoints, lineWidth: CHART_LINE_DEFALUT_WIDTH, color: FDTWMColor.activeColor.color)
        self.drawLayer(context: context, rect: rect, points: priceLinePoints)
        //昨收线
        let prePriceLinePointY = originPoint.y + (self.viewModel.maxPrice - self.viewModel.preClosePrice!) * unitY
        FDTChartDrawTools.drawDashLine(context: context,
                                       startPoint: CGPoint(x: originPoint.x, y: prePriceLinePointY),
                                       endPoint: CGPoint(x: originPoint.x + lineChartWidth, y: prePriceLinePointY))
        //昨收价文字
        //左
        let prePriceStr = NSString(format: "%.2f", self.viewModel.preClosePrice!)
        var stringSize = FDTWMUiUtility.stringSize(string: prePriceStr as String, withAttributes: attr)
        var pointY = originPoint.y + (self.viewModel.maxPrice - CGFloat(self.viewModel.preClosePrice!)) * unitY
        var drawPoint = CGPoint(x: originPoint.x,
                                y: pointY - stringSize.height / 2.0)
        prePriceStr.draw(at: drawPoint, withAttributes: attr)
        //右
        let prePricePersentStr: NSString = "0.00%"
        stringSize = FDTWMUiUtility.stringSize(string: prePricePersentStr as String, withAttributes: attr)
        pointY = originPoint.y + (self.viewModel.maxPrice - CGFloat(self.viewModel.preClosePrice!)) * unitY
        drawPoint = CGPoint(x: originPoint.x + lineChartWidth - stringSize.width,
                            y: pointY - stringSize.height / 2.0)
        prePricePersentStr.draw(at: drawPoint, withAttributes: attr)
        
        if CHART_TIMELINE_SHOW_INDEX {
            //绘制成交量指标
            let volumeUnitY = indexChartHeight / (self.viewModel.maxVolume - self.viewModel.minVolume)
            let volumeStartPointY = originPoint.y + lineChartHeight + CHART_SECTION_GAP
            for (index, item) in lineItems.enumerated() {
                let volumePointX = CGFloat(index) * unitX + CHART_LEFT_GAP
                let volumePointY = volumeStartPointY + (self.viewModel.maxVolume - CGFloat(item.volume.floatValue)) * volumeUnitY
                //成交量颜色
                let color = FDTWMColor.marketCloseColor.color
                let volumeStartPoint = CGPoint(x: volumePointX, y: volumePointY)
                let volumeEndPoint = CGPoint(x: volumePointX,
                                             y: originPoint.y + viewHeight - CHART_TOP_BOTTOM_GAP)
                FDTChartDrawTools.drawLine(context: context,
                                           startPoint: volumeStartPoint,
                                           endPoint: volumeEndPoint,
                                           lineWidth: CHART_LINE_DEFALUT_WIDTH,
                                           color: color)
            }
        }
        
        if isLongPress {
            let volumeStartPointY = originPoint.y + lineChartHeight + CHART_SECTION_GAP
            var startPoint = CGPoint.zero
            var endPoint = CGPoint.zero
            //竖线
            //分时图区域
            startPoint = CGPoint(x: CGFloat(activeIndex) * unitX + CHART_LEFT_GAP,
                                 y: originPoint.y)
            endPoint = CGPoint(x: CGFloat(activeIndex) * unitX + CHART_LEFT_GAP,
                               y: originPoint.y + lineChartHeight)
            FDTChartDrawTools.drawDashLine(context: context,
                                           startPoint: startPoint,
                                           endPoint: endPoint,
                                           lineWidth: CHART_LINE_CROSS_WIDTH,
                                           color: FDTWMColor.activeColor.color)
            //成交量区域
            startPoint = CGPoint(x: CGFloat(activeIndex) * unitX + CHART_LEFT_GAP,
                                 y: volumeStartPointY)
            endPoint = CGPoint(x: CGFloat(activeIndex) * unitX + CHART_LEFT_GAP,
                               y: volumeStartPointY + indexChartHeight)
            FDTChartDrawTools.drawDashLine(context: context,
                                           startPoint: startPoint,
                                           endPoint: endPoint,
                                           lineWidth: CHART_LINE_CROSS_WIDTH,
                                           color: FDTWMColor.activeColor.color)
            
            //横线
            pointY = activeLocation.y
            if pointY <= originPoint.y {
                pointY = originPoint.y
            }
            if pointY >= originPoint.y + viewHeight - CHART_TOP_BOTTOM_GAP {
                pointY = originPoint.y + viewHeight - CHART_TOP_BOTTOM_GAP
            }
            if pointY > originPoint.y + lineChartHeight &&
                pointY < originPoint.y + lineChartHeight + CHART_SECTION_GAP{
                pointY = originPoint.y + lineChartHeight
            }
            
            startPoint = CGPoint(x: originPoint.x,
                                 y: pointY)
            endPoint = CGPoint(x: originPoint.x + lineChartWidth,
                               y: pointY)
            FDTChartDrawTools.drawDashLine(context: context,
                                           startPoint: startPoint,
                                           endPoint: endPoint,
                                           lineWidth: CHART_LINE_CROSS_WIDTH,
                                           color: FDTWMColor.activeColor.color)
            
            //长按显示颜色
            attr = [NSAttributedStringKey.font: UIFont.dinLightFontOfSize(14),
                    NSAttributedStringKey.foregroundColor: FDTWMColor.marketCloseColor.color,
                    NSAttributedStringKey.backgroundColor: FDTWMColor.selectedColor.color]
            
            //下方时间轴
            var time = self.viewModel.lineItems[activeIndex].dataTime!
            time.insert(":", at: time.index(time.startIndex, offsetBy: 2))
            let timeStr = time as NSString
            stringSize = FDTWMUiUtility.stringSize(string: time, withAttributes: attr)
            var pointX = CGFloat(activeIndex) * unitX - stringSize.width / 2
            
            if pointX <= stringSize.width / 2 {
                pointX = originPoint.x
            } else if pointX >= lineChartWidth - stringSize.width {
                pointX = originPoint.x + lineChartWidth - stringSize.width
            }
            pointX = pointX + CHART_LEFT_GAP
            drawPoint = CGPoint(x: pointX,
                                y: originPoint.y + lineChartHeight)
            timeStr.draw(at: drawPoint, withAttributes: attr)
            
            
            let lineChartRect = CGRect(x: originPoint.x,
                                       y: originPoint.y,
                                       width: lineChartWidth,
                                       height: lineChartHeight)
            let indexChartRect = CGRect(x: originPoint.x,
                                        y: originPoint.y + lineChartHeight + CHART_SECTION_GAP,
                                        width: indexChartWidth,
                                        height: indexChartHeight)
            //如果在分时图区域
            if lineChartRect.contains(activeLocation) {
                //左边价格
                let priceUnitY = (self.viewModel.maxPrice - self.viewModel.minPrice) / lineChartHeight
                pointY = activeLocation.y - originPoint.y
                if pointY < 0 {
                    pointY = 0
                } else if pointY > lineChartHeight {
                    pointY = lineChartHeight
                }
                let price = self.viewModel.maxPrice -  pointY * priceUnitY
                let priceStr = NSString(format: "%.2f", price)
                stringSize = FDTWMUiUtility.stringSize(string: priceStr as String, withAttributes: attr)
                pointY = activeLocation.y - stringSize.height / 2
                if pointY <= originPoint.y + stringSize.height / 2 {
                    pointY = originPoint.y
                } else if pointY >= (originPoint.y + lineChartHeight - stringSize.height) {
                    pointY = originPoint.y + lineChartHeight - stringSize.height
                }
                drawPoint = CGPoint(x: originPoint.x,
                                    y: pointY)
                priceStr.draw(at: drawPoint, withAttributes: attr)
                //右边价格百分比
                let pricePersent = (price - self.viewModel.preClosePrice!) / self.viewModel.preClosePrice! * 100
                let pricePersentStr = NSString(format: "%.2f%%", pricePersent)
                stringSize = FDTWMUiUtility.stringSize(string: pricePersentStr as String, withAttributes: attr)
                pointY = activeLocation.y - stringSize.height / 2
                if pointY <= originPoint.y + stringSize.height / 2 {
                    pointY = originPoint.y
                } else if pointY >= (originPoint.y + lineChartHeight - stringSize.height) {
                    pointY = originPoint.y + lineChartHeight - stringSize.height
                }
                drawPoint = CGPoint(x: originPoint.x + lineChartWidth - stringSize.width,
                                    y: pointY)
                pricePersentStr.draw(at: drawPoint, withAttributes: attr)
            } else if indexChartRect.contains(activeLocation) {
                let volumeUnitY = (self.viewModel.maxVolume - self.viewModel.minVolume) / indexChartHeight
                pointY = activeLocation.y - originPoint.y - lineChartHeight - CHART_SECTION_GAP
                if pointY < 0 {
                    pointY = 0
                } else if pointY > indexChartHeight {
                    pointY = indexChartHeight
                }
                let volume = self.viewModel.maxVolume -  pointY * volumeUnitY
                let volumeStr = NSString(format: "%.0f", volume)
                stringSize = FDTWMUiUtility.stringSize(string: volumeStr as String, withAttributes: attr)
                
                pointY = activeLocation.y - stringSize.height / 2
                if pointY <= originPoint.y + lineChartHeight + CHART_SECTION_GAP + stringSize.height / 2 {
                    pointY = originPoint.y + lineChartHeight + CHART_SECTION_GAP
                } else if pointY > viewHeight - CHART_BOTTOM_GAP - stringSize.height {
                    pointY = viewHeight - CHART_BOTTOM_GAP - stringSize.height
                }
                print("volume:\(volumeStr)")
                drawPoint = CGPoint(x: originPoint.x,
                                    y: pointY)
                volumeStr.draw(at: drawPoint, withAttributes: attr)
            }
            
        }
    }

    func drawLayer(context: CGContext, rect: CGRect, points: [CGPoint]) {
        let shapeLayerPath = UIBezierPath.init()
        let firstPoint = points.first!
        var lastPoint = CGPoint.zero
        shapeLayerPath.move(to: firstPoint)
        for (index, item) in points.enumerated() {
            if index == 0 {
                continue
            }
            shapeLayerPath.addLine(to: item)
        }
        lastPoint.x = points.last!.x
        lastPoint.y = originPoint.y + lineChartHeight
        shapeLayerPath.addLine(to: lastPoint)
        lastPoint.x = points.first!.x
        shapeLayerPath.addLine(to: lastPoint)
        shapeLayerPath.close()
        
        gradLayer = CAGradientLayer.init()
        gradLayer?.frame = CGRect(x: 0,
                                  y: 0,
                                  width: viewWidth,
                                  height: lineChartHeight)
        gradLayer?.colors = [UIColor(wmColor: FDTWMColor.layerColor, alpha: 0.12).cgColor,
                             UIColor(wmColor: FDTWMColor.layerColor, alpha: 0.12).cgColor,
                             UIColor(wmColor: FDTWMColor.whiteColor, alpha: 0.1).cgColor]
        gradLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradLayer?.endPoint = CGPoint(x: 0, y: 1)
        gradLayer?.locations = [0, 0.5, 0.95, 1]
        
        let shaperLayer = CAShapeLayer.init()
        shaperLayer.path = shapeLayerPath.cgPath
        gradLayer?.mask = shaperLayer
        self.layer.addSublayer(gradLayer!)
    }
    
    //绘制边框文字
    func drawBoxText(context: CGContext, rect: CGRect) {
        //最大值
        var drawPoint = originPoint
        var startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        var stringSize = CGSize.zero
        let maxPriceStr = String(format: "%.2f", self.viewModel.maxPrice)
        let attr = [NSAttributedStringKey.font: UIFont.dinLightFontOfSize(14),
                    NSAttributedStringKey.foregroundColor: FDTWMColor.grayTextColor.color]
        FDTChartDrawTools.drawText(maxPriceStr, atPoint: drawPoint, withAttributes: attr)
        
        //最小值
        let minPriceStr = String(format: "%.2f", self.viewModel.minPrice)
        stringSize = FDTWMUiUtility.stringSize(string: minPriceStr, withAttributes: attr)
        drawPoint = CGPoint(x: originPoint.x,
                            y: originPoint.y + lineChartHeight - stringSize.height)
        FDTChartDrawTools.drawText(minPriceStr, atPoint: drawPoint, withAttributes: attr)
        
        //最大百分比
        let maxPricePersentStr = String(format: "%.2f%%", self.viewModel.maxPricePersent)
        stringSize = FDTWMUiUtility.stringSize(string: maxPricePersentStr, withAttributes: attr)
        drawPoint = CGPoint(x: originPoint.x + lineChartWidth - stringSize.width,
                            y: originPoint.y)
        FDTChartDrawTools.drawText(maxPricePersentStr, atPoint: drawPoint, withAttributes: attr)
        
        //最小百分比
        let minPricePersentStr = String(format: "%.2f%%", self.viewModel.minPricePersent)
        stringSize = FDTWMUiUtility.stringSize(string: minPricePersentStr, withAttributes: attr)
        drawPoint = CGPoint(x: originPoint.x + lineChartWidth - stringSize.width,
                            y: originPoint.y + lineChartHeight - stringSize.height)
        FDTChartDrawTools.drawText(minPricePersentStr, atPoint: drawPoint, withAttributes: attr)
        
        //绘制下方时间
        // 第一个和最后一个不绘制竖线，边框已经绘制过
        let timePosision = self.viewModel.getTimePosition()
        for (index, item) in timePosision.enumerated() {
            let pos = item["pos"] as! Int
            let timeStr = (item["time"] as! String) as NSString
            //第一条
            if index == 0 {
                drawPoint = CGPoint(x: originPoint.x,
                                    y: originPoint.x + lineChartHeight)
                timeStr.draw(at: drawPoint, withAttributes: attr)
            } else if index == timePosision.count - 1 { //最后一条
                stringSize = FDTWMUiUtility.stringSize(string: timeStr as String, withAttributes: attr)
                drawPoint = CGPoint(x: originPoint.x + lineChartWidth - stringSize.width,
                                    y: originPoint.x + lineChartHeight)
                timeStr.draw(at: drawPoint, withAttributes: attr)
            } else {
                let pointX = originPoint.x + CGFloat(pos) * unitX
                startPoint = CGPoint(x: pointX, y: originPoint.y)
                endPoint = CGPoint(x: pointX, y: originPoint.y + lineChartHeight)
                FDTChartDrawTools.drawDashLine(context: context,
                                               startPoint: startPoint,
                                               endPoint: endPoint)
                stringSize = FDTWMUiUtility.stringSize(string: timeStr as String, withAttributes: attr)
                drawPoint = CGPoint(x: originPoint.x + pointX - stringSize.width / 2,
                                    y: originPoint.y + lineChartHeight)
                timeStr.draw(at: drawPoint, withAttributes: attr)
            }
        }
        //不绘制指标区域
        if !CHART_TIMELINE_SHOW_INDEX {
            return
        }
        //成交量最大值
        let maxVolumeStr = String(format: "%.f", self.viewModel.maxVolume)
        drawPoint = CGPoint(x: originPoint.x,
                            y: originPoint.y + lineChartHeight + CHART_SECTION_GAP)
        FDTChartDrawTools.drawText(maxVolumeStr, atPoint: drawPoint, withAttributes: attr)
    }
    
    func drawBox(context: CGContext,rect: CGRect) {
        //----整体线框 start ---
        //绘制整体线框
        //上
        var startPoint = originPoint
        var endPoint = CGPoint(x: originPoint.x + lineChartWidth,
                               y: originPoint.y)
        FDTChartDrawTools.drawLine(context: context,
                                   startPoint: startPoint,
                                   endPoint: endPoint)
        //下
        startPoint = CGPoint(x: originPoint.x,
                             y: originPoint.y + lineChartHeight)
        endPoint = CGPoint(x: originPoint.x + lineChartWidth,
                           y: originPoint.y + lineChartHeight)
        FDTChartDrawTools.drawLine(context: context,
                                   startPoint: startPoint,
                                   endPoint: endPoint)
        
        //左
        startPoint = originPoint
        endPoint = CGPoint(x: originPoint.x,
                           y: originPoint.y + lineChartHeight)
        FDTChartDrawTools.drawLine(context: context,
                                   startPoint: startPoint,
                                   endPoint: endPoint)
        
        //右
        startPoint = CGPoint(x: originPoint.x + lineChartWidth,
                             y: originPoint.y)
        endPoint = CGPoint(x: originPoint.x + lineChartWidth,
                           y: originPoint.y + lineChartHeight)
        FDTChartDrawTools.drawLine(context: context,
                                   startPoint: startPoint,
                                   endPoint: endPoint)
        
        //不绘制指标区域
        if !CHART_TIMELINE_SHOW_INDEX {
            return
        }
        //下方指标线框
        //上
        startPoint = CGPoint(x: originPoint.x,
                             y: originPoint.y + lineChartHeight + CHART_SECTION_GAP)
        endPoint = CGPoint(x: originPoint.x + indexChartWidth,
                           y: originPoint.y + lineChartHeight + CHART_SECTION_GAP)
        FDTChartDrawTools.drawLine(context: context,
                                   startPoint: startPoint,
                                   endPoint: endPoint)
        //下
        startPoint = CGPoint(x: originPoint.x,
                             y: originPoint.y + lineChartHeight + CHART_SECTION_GAP + indexChartHeight)
        endPoint = CGPoint(x: originPoint.x + indexChartWidth,
                           y: originPoint.y + lineChartHeight + CHART_SECTION_GAP + indexChartHeight)
        FDTChartDrawTools.drawLine(context: context, startPoint: startPoint, endPoint: endPoint)
        
        //左
        startPoint = CGPoint(x: originPoint.x,
                             y: originPoint.y + lineChartHeight + CHART_SECTION_GAP)
        endPoint = CGPoint(x: originPoint.x,
                           y: originPoint.y + lineChartHeight + CHART_SECTION_GAP + indexChartHeight)
        FDTChartDrawTools.drawLine(context: context, startPoint: startPoint, endPoint: endPoint)
        
        //右
        startPoint = CGPoint(x: originPoint.x + indexChartWidth,
                             y: originPoint.y + lineChartHeight + CHART_SECTION_GAP)
        endPoint = CGPoint(x: originPoint.x + indexChartWidth,
                           y: originPoint.y + lineChartHeight + CHART_SECTION_GAP + indexChartHeight)
        FDTChartDrawTools.drawLine(context: context, startPoint: startPoint, endPoint: endPoint)
        //----整体线框 end-----
    }
    
    // MARK: ViewModelProtocol
    func refreshUI() {
        self.setNeedsDisplay()
    }

}
