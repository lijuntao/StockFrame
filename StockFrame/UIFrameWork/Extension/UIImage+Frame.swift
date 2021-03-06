//
//  UIImage+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    /// 改变图片tint颜色
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - blendMode: 参数
    /// - Returns: 新的图片
    func tint(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage {
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    class func image(_ name: String) -> UIImage {
        return UIImage.init(named: name)!
    }
    
    enum Asset: String {
        
        case Stock = "stock"
        case Stock_select = "stock_slect"
        case Financial = "financial"
        case Financial_select = "financial_select"
        case Transaction = "transaction"
        case Transaction_select = "transaction_select"
        case Mine = "mine"
        case Mine_select = "mine_select"
        case Nav_refresh = "nav_refresh"
        case Nav_backArrow = "nav_backArrow"
        case Market_empty = "market_empty"
        case Optional_no_add = "optional_no_add"
        case List_left = "list_left"
        case List_bottom = "list_bottom"
        case More_dot = "more_dot"
        case Toast = "toast"
        case Sort_arrowbottom = "sort_arrowbottom"
        case Sort_arrowtop = "sort_arrowtop"
        //--------分割线
        /*
        case LoginImage = "LoginImage"
        case LoginImageX = "LoginImageX"
        case LoginImageW = "LoginImageW"
        case LoginImageWX = "LoginImageWX"
        case Oval55 = "Oval55"
        case Account_buy = "account_buy"
        case Account_quotes = "account_quotes"
        case Account_sell = "account_sell"
        case Account_share = "account_share"
        case Add_normal = "add_normal"
        case Add_pressed = "add_pressed"
        case Add_select = "add_select"
        case Add_self_choose = "add_self_choose"
        case Add_self_choose_new = "add_self_choose_new"
        case Add_self_choose_new_disabled = "add_self_choose_new_disabled"
        case Add_self_choose_ok = "add_self_choose_ok"
        case Add_self_choose_ok_pressed = "add_self_choose_ok_pressed"
        case Arrow_bigone_right = "arrow_bigone_right"
        case Bg_dialog_touchid = "bg_dialog_touchid"
        case Bg_login_logo = "bg_login_logo"
        case Bg_me_build = "bg_me_build"
        case Bg_me_user_thumbnail_default = "bg_me_user_thumbnail_default"
        case Bg_portfolio_expand_arrow = "bg_portfolio_expand_arrow"
        case Bg_security_confirm = "bg_security_confirm"
        case Black_small_arrow_down = "black_small_arrow_down"
        case Calendar = "calendar"
        case Camera = "camera"
        case Camera_btn = "camera_btn"
        case Camera_not_select = "camera_not_select"
        case Camera_pressed = "camera_pressed"
        case Camera_select = "camera_select"
        case Camera_word = "camera_word"
        case Cash = "cash"
        case Cbbc = "cbbc"
        case China = "china"
        case Circle = "circle"
        case Close = "close"
        case Commodity = "commodity"
        case Commodity_pressed = "commodity_pressed"
        case Delete = "delete"
        case Delete_pressed = "delete_pressed"
        case Details_financing = "details_financing"
        case Edit_change_location = "edit_change_location"
        case Edit_delete = "edit_delete"
        case Edit_not_select = "edit_not_select"
        case Edit_select = "edit_select"
        case Edit_up = "edit_up"
        case Eye_close = "eye_close"
        case Eye_open = "eye_open"
        case Fengtou_logo = "fengtou_logo"
        case Full = "full"
        case Full_pressed = "full_pressed"
        case Gold = "gold"
        case Golden_small_arrow = "golden_small_arrow"
        case Golden_small_arrow_pressed = "golden_small_arrow_pressed"
        case Grey_small_arrow = "grey_small_arrow"
        case Grey_small_arrow_down = "grey_small_arrow_down"
        case Hong_kong = "hong_kong"
        case Icon_cell_check = "icon_cell_check"
        case Icon_list_expand_n = "icon_list_expand_n"
        case Icon_list_next_n = "icon_list_next_n"
        case Icon_list_s_cir_expand_f = "icon_list_s_cir_expand_f"
        case Icon_list_s_cir_expand_n = "icon_list_s_cir_expand_n"
        case Icon_list_s_expand_f = "icon_list_s_expand_f"
        case Icon_list_s_expand_n = "icon_list_s_expand_n"
        case Icon_list_s_next_n = "icon_list_s_next_n"
        case Icon_nav_back_n = "icon_nav_back_n"
        case Icon_nav_close_n = "icon_nav_close_n"
        case Icon_nav_refresh_n = "icon_nav_refresh_n"
        case Icon_nav_search_n = "icon_nav_search_n"
        case Icon_nav_setting = "icon_nav_setting"
        case Icon_nav_setting_n = "icon_nav_setting_n"
        case Icon_navbar_discover_f = "icon_navbar_discover_f"
        case Icon_navbar_discover_n = "icon_navbar_discover_n"
        case Icon_navbar_im_f = "icon_navbar_im_f"
        case Icon_navbar_im_n = "icon_navbar_im_n"
        case Icon_navbar_me_f = "icon_navbar_me_f"
        case Icon_navbar_me_n = "icon_navbar_me_n"
        case Icon_navbar_portfolio_f = "icon_navbar_portfolio_f"
        case Icon_navbar_portfolio_n = "icon_navbar_portfolio_n"
        case Icon_password_f = "icon_password_f"
        case Icon_password_n = "icon_password_n"
        case Icon_pincode_delete_n = "icon_pincode_delete_n"
        case Icon_pincode_delete_p = "icon_pincode_delete_p"
        case Icon_portfolio_add_f = "icon_portfolio_add_f"
        case Icon_portfolio_add_n = "icon_portfolio_add_n"
        case Icon_portfolio_im_n = "icon_portfolio_im_n"
        case Icon_portfolio_move_n = "icon_portfolio_move_n"
        case Icon_portfolio_movetop_n = "icon_portfolio_movetop_n"
        case Icon_portfolio_select_f = "icon_portfolio_select_f"
        case Icon_portfolio_select_n = "icon_portfolio_select_n"
        case Icon_portfolio_sort = "icon_portfolio_sort"
        case Icon_portfolio_sort_arrowbottom = "icon_portfolio_sort_arrowbottom"
        case Icon_portfolio_sort_arrowtop = "icon_portfolio_sort_arrowtop"
        case Icon_search_add_f = "icon_search_add_f"
        case Icon_search_add_n = "icon_search_add_n"
        case Icon_snackbar_alert_red = "icon_snackbar_alert_red"
        case Icon_toast_alert = "icon_toast_alert"
        case Icon_toast_block = "icon_toast_block"
        case Icon_toast_success = "icon_toast_success"
        case Image = "image"
        case Image_pressed = "image_pressed"
        case Interpret = "interpret"
        case Invite_friends = "invite_friends"
        case Keyboard = "keyboard"
        case Keyboard_pressed = "keyboard_pressed"
        case Login = "login"
        case Logo_white_bg = "logo_white_bg"
        case Minus = "minus"
        case Minus_pressed = "minus_pressed"
        case More_dot = "more_dot"
        case Nav_add_self_choose = "nav_add_self_choose"
        case Nav_add_self_choose_disabled = "nav_add_self_choose_disabled"
        case Nav_add_self_choose_pressed = "nav_add_self_choose_pressed"
        case Nav_bar_arrow = "nav_bar_arrow"
        case Nav_edit = "nav_edit"
        case Nav_head_portrait = "nav_head_portrait"
        case Nav_help = "nav_help"
        case Nav_nav_refresh = "nav_nav_refresh"
        case Nav_refresh_pressed = "nav_refresh_pressed"
        case Nav_search = "nav_search"
        case Nav_setting = "nav_setting"
        case Order_filter_arrow = "order_filter_arrow"
        case Order_minus = "order_minus"
        case Order_plus = "order_plus"
        case Optional_add_whitebg = "optional_add_whitebg"
        case Optional_add = "optional_add"
        case Optional_edit = "optional_edit"
        case Optional_warm = "optional_warm"
        case Optional_tag_all = "optional_tag_all"
        case Optional_tag_us = "optional_tag_us"
        case Optional_tag_hk = "optional_tag_hk"
        case Optional_tag_cn = "optional_tag_cn"
        case Optional_group = "optional_group"
        case Optional_move = "optional_move"
        case Phone = "phone"
        case Phone_pressed = "phone_pressed"
        case Plus = "plus"
        case Plus_pressed = "plus_pressed"
        case Pop_select = "pop_select"
        case Qq = "qq"
        case Read = "read"
        case Remind = "remind"
        case Reminded = "reminded"
        case Search_small = "search_small"
        case Select_triangle = "select_triangle"
        case Selected_hook = "selected_hook"
        case Service = "service"
        case Service_select = "service_select"
        case Service_feedback_add = "service_feedback_add"
        case Setting = "setting"
        case Sign = "sign"
        case Stock_market_stock_hk = "stock_market_stock_hk"
        case Stock_market_stock_sh = "stock_market_stock_sh"
        case Stock_market_stock_sz = "stock_market_stock_sz"
        case Stock_market_stock_us = "stock_market_stock_us"
        case Stock_left_clickable = "stock_left_clickable"
        case Stock_left_unclickable = "stock_left_unclickable"
        case Stock_right_clickable = "stock_right_clickable"
        case Stock_right_unclickable = "stock_right_unclickable"
        case Stock_exchange = "stock_exchange"
        case Stock_financing = "stock_financing"
        case Share_nav = "share_nav"
        case Time_weituodan = "time_weituodan"
        case Upload_image = "upload_image"
        case Upload_take_pic = "upload_take_pic"
        case Us = "us"
        case Voice_big = "voice_big"
        case Voice_big_pressed = "voice_big_pressed"
        case Voice_normal = "voice_normal"
        case Voice_pressed = "voice_pressed"
        case Voice_select = "voice_select"
        case Weibo = "weibo"
        case Weichat = "weichat"
        case White = "white"
        case White_right = "white_right"
        case Upgrade = "upgrade"
        case Stock_transaction = "stock_transaction"
        case Market_Close = "market_close"
        */
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
