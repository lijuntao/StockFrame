//
//  FDTChartDrawTools.swift
//  StockFrame
//
//  Created by fdt on 2018/7/26.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTChartDrawTools: NSObject {
    
    class func drawLine(context: CGContext,
                        startPoint start: CGPoint,
                        endPoint end: CGPoint,
                        lineWidth width: CGFloat = CHART_LINE_DEFALUT_WIDTH,
                        color: UIColor = FDTWMColor.defalutLineColor.color) {
        context.saveGState()
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        context.move(to: start)
        context.addLine(to: end)
        context.strokePath()
        context.restoreGState()
    }
    
    class func drawLine(context: CGContext,
                        pointArray array: [CGPoint],
                        lineWidth width: CGFloat = CHART_LINE_DEFALUT_WIDTH,
                        color: UIColor = FDTWMColor.defalutLineColor.color) {
        context.saveGState()
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        
        for (index, point) in array.enumerated() {
            if index == 0 {
                context.move(to: point)
                continue
            }
            context.addLine(to: point)
        }
        context.strokePath()
        context.restoreGState()
    }
    
    class func drawDashLine(context: CGContext,
                            startPoint start: CGPoint,
                            endPoint end: CGPoint,
                            lineWidth width: CGFloat = CHART_LINE_DEFALUT_WIDTH,
                            color: UIColor = FDTWMColor.defalutLineColor.color) {
        context.saveGState()
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        let lengths: [CGFloat] = [3,2]
        context.setLineDash(phase: 0, lengths: lengths)
        context.move(to: start)
        context.addLine(to: end)
        context.strokePath()
        context.restoreGState()
    }
    
    class func drawText(_ text: String,
                        atPoint point: CGPoint,
                        withAttributes attribute: [NSAttributedStringKey : Any]) {
        let textStr = text as NSString
        textStr.draw(at: point, withAttributes: attribute)
    }
    
    class func drawText(_ text: String,
                        atRect rect: CGRect,
                        withAttributes attribute: [NSAttributedStringKey : Any]) {
        let textStr = text as NSString
        textStr.draw(in: rect, withAttributes: attribute)
    }
    
    class func fillRect(context: CGContext,
                        withRect rect: CGRect,
                        color: UIColor) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fill(rect)
        context.restoreGState()
    }
    
}
