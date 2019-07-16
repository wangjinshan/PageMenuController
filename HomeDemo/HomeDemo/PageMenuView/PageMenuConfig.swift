//
//  PageMenuConfig.swift
//  HomeDemo
//
//  Created by 山神 on 2019/7/11.
//  Copyright © 2019 山神. All rights reserved.
//

import UIKit

class PageMenuViewConfig {
    open var customLayoutMenuView:Bool = true
    open var menuItemLeftMargin : CGFloat = 25.0
    open var menuItemMargin : CGFloat = 12.0
    open var menuHeight:CGFloat = 45.0
    open var menuBackgroundColor = UIColor.white
    open var indicatorTopMargin:CGFloat = 4.0
    open var indicatorWidthBasedOnTitleTextWidth:Bool = true
    open var enableHorizontalBounce : Bool = false
    open var scrollAnimationDurationOnMenuItemTap:Int = 300
    open var viewBackgroundColor : UIColor = UIColor.white
    open var selectionIndicatorColor: UIColor = UIColor.red
    open var selectionIndicatorHeight:CGFloat = 4.0
    open var selectionIndicatorWidth:CGFloat = 18.0
    
    init() {}
}

class PageMenuItemConfig {
    open var menuItemSelectedBackgroundColor:UIColor = UIColor.cyan
    open var menuItemUnSelectedBackgroundColor:UIColor = UIColor.white
    open var menuItemTopMargin:CGFloat = 0
    open var menuItemBottomMargin:CGFloat = 8
    open var menuItemCornerRadius:CGFloat = 0
    open var menuItemLabelBottomMargin:CGFloat = 0
    open var menuItemTitleIconMargin:CGFloat = 3
    open var menuItemWidth:CGFloat = 51.0
    open var menuItemHeight:CGFloat = 45.0
    open var menuItemTitle:String = ""
    open var menuItemIcon:String = ""
    
    open var unselectedMenuItemLabelFont:UIFont = UIFont.systemFont(ofSize: 14)
    open var unselectedMenuItemLabelColor:UIColor = UIColor.black
    open var selectedMenuItemLabelFont:UIFont = UIFont.systemFont(ofSize: 20)
    open var selectedMenuItemLabelColor:UIColor = UIColor.red
    
    init() {}
}



