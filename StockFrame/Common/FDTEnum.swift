//
//  FDTEnum.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

enum FDTWMColor: NSNumber {
    
    case backColor = 0xEFEFEF
    
    case goldColor = 0xBE9862
    case szColor = 0xC84845 //深股的背景色
    case goldNewColor = 0xe8c082
    case goldNewColor1 = 0xBA9560
    case grayNewColor = 0x72727a
    case grayNewColor1 = 0xB2B2B2
    case grayNewColor2 = 0x585858
    
    case redColor = 0xe93030
    case greenColor = 0x009900
    case whiteColor = 0xfefefe
    case white2Color = 0xf8f8f8
    case white3Color = 0xffffff
    case white4Color = 0xEEEEEE
    case black1Color = 0x292006
    case black2Color = 0x544d38
    case black3Color = 0x7f7a6a
    case black4Color = 0xaaa69c
    case black5Color = 0xd5d3ce
    case black6Color = 0x1e1e1e
    case black7Color = 0xDBDBDB
    case black8Color = 0x666666
    case black9Color = 0x000000
    case black10Color = 0x3d3d3d
    case black11Color = 0x575757
    case black12Color = 0x47484d
    case black13Color = 0x090909
    case unchangeColor = 0x007AFF
    case dividerColor = 0xEFEFF4
    case divider1Color = 0xE0E0E0
    case marketCloseColor = 0x808080
    case responsiveInteraction = 0xE5E5E5
    case responsiveGoldInteraction = 0xaa8858
    case azulColor = 0x256be7
    case reddishColor = 0xcd433f
    case windowsBlueColor = 0x3f7dcd
    case terracotaColor = 0xcd813f
    //    case SymbolSHColor = 0xBE9862
    case symbolHKColor = 0xE07D46
    case symbolUSColor = 0x2387DF
    case valueRiseColor = 0xE14440
    case valueFallColor = 0x1EAC3E
    
    case navigationColor = 0x34353a
    case greyLineColor = 0xD8D8D8
    
    case rejctedColor = 0xff4440
    case cancelBlueColor = 0x3678D4
    
    case grayColor = 0xA7A7A7
    case gray1Color = 0xE9E9E9
    case gray2Color = 0x858588
    case gray3Color = 0x5C5D61
    var color: UIColor{
        return UIColor(wmColor: self, alpha: 1)
    }
    
    func alpha(_ alpha: CGFloat)-> UIColor {
        return UIColor(wmColor: self, alpha: alpha)
    }
}
