
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
        titleLabel.text = config.menuItemTitle
            imageView.image = UIImage(named: config.menuItemIcon)
        titleLabel.textAlignment = .center
        layoutItem(config: config)
        layer.cornerRadius = config.menuItemCornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelectedState(config: PageMenuItemConfig) {
        titleLabel.font = config.selectedMenuItemLabelFont
        titleLabel.textColor  = config.selectedMenuItemLabelColor
        backgroundColor = config.menuItemUnSelectedBackgroundColor
    }
    func configureNormalState(config: PageMenuItemConfig) {
        titleLabel.font = config.unselectedMenuItemLabelFont
        titleLabel.textColor  = config.unselectedMenuItemLabelColor
        backgroundColor = config.menuItemSelectedBackgroundColor
    }
    
    func layoutItem(config:PageMenuItemConfig)  {
        titleLabel.text = config.menuItemTitle
        imageView.image = UIImage(named: config.menuItemIcon)
        if config.menuItemIcon.isEmpty {
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(config.menuItemTopMargin)
                make.left.right.bottom.equalTo(0)
            }
        }else{
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(config.menuItemTopMargin)
                make.left.bottom.equalTo(0)
            }
            imageView.snp.remakeConstraints { (make) in
                make.left.equalTo(titleLabel.snp.right).offset(config.menuItemTitleIconMargin)
                make.right.equalTo(0)
                make.centerY.equalTo(titleLabel.snp.centerY)
            }
        }
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
