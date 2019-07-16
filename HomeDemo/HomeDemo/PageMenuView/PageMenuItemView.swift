
//
//  PageMenuItemView.swift
//  HomeDemo
//
//  Created by 山神 on 2019/7/11.
//  Copyright © 2019 山神. All rights reserved.
//

import UIKit
import SnapKit

class PageMenuItemView: UIView {
    
    var titleLabel = UILabel()
    var imageView = UIImageView()
    var config = PageMenuItemConfig()
    
    init(options:[PageMenuItemViewOption]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 66.0, height: 34))
        configurePageMenuItemView(options: options)
        frame = CGRect(x: 0, y: config.menuItemTopMargin, width: config.menuItemWidth, height: config.menuItemHeight - config.menuItemBottomMargin)
        addSubview(titleLabel)
        addSubview(imageView)
        
        titleLabel.textAlignment = .center
        layer.cornerRadius = config.menuItemCornerRadius
        setItemContent(config: config)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        imageView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(titleLabel.snp.top).offset(-3)
            make.height.equalTo(18)
            make.width.equalTo(35)
            make.left.equalTo(titleLabel.snp.left).offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelectedState(config: PageMenuItemConfig) {
        titleLabel.font = config.selectedMenuItemLabelFont
        titleLabel.textColor  = config.selectedMenuItemLabelColor
        backgroundColor = config.menuItemUnSelectedBackgroundColor
        titleLabel.snp.updateConstraints { (make) in
            make.bottom.equalTo(0)
        }
    }
    func configureNormalState(config: PageMenuItemConfig) {
        titleLabel.font = config.unselectedMenuItemLabelFont
        titleLabel.textColor  = config.unselectedMenuItemLabelColor
        backgroundColor = config.menuItemUnSelectedBackgroundColor
        titleLabel.snp.updateConstraints{ (make) in
            make.bottom.equalTo(-2)
        }
    }
    
    func setItemContent(config:PageMenuItemConfig)  {
        titleLabel.text = config.menuItemTitle
        imageView.image = UIImage(named: config.menuItemIcon)
    }
}

extension PageMenuItemView {
    func configurePageMenuItemView(options: [PageMenuItemViewOption]) {
        for option in options {
            switch (option) {
            case let .menuItemSelectedBackgroundColor(value):
                config.menuItemSelectedBackgroundColor = value
            case let .menuItemUnSelectedBackgroundColor(value):
                config.menuItemUnSelectedBackgroundColor = value
            case let .menuItemCornerRadius(value):
                config.menuItemCornerRadius = value
            case let .menuItemBottomMargin(value):
                config.menuItemBottomMargin = value
            case let .menuItemWidth(value):
                config.menuItemWidth = value
            case let .menuItemTitle(value):
                config.menuItemTitle = value
            case let .menuItemIcon(value):
                config.menuItemIcon = value
            case let .menuItemHeight(value):
                config.menuItemHeight = value
            case let .menuItemTitleIconMargin(value):
                config.menuItemTitleIconMargin = value
            case let .menuItemLabelBottomMargin(value):
                config.menuItemLabelBottomMargin = value
            case let .menuItemTopMargin(value):
                config.menuItemTopMargin = value
            }
        }
    }
    
}
