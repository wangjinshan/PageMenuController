
//
//  PageMenuController.swift
//  HomeDemo
//
//  Created by 山神 on 2019/7/11.
//  Copyright © 2019 山神. All rights reserved.
//

import UIKit
@objc public protocol PageMenuControllerDelegate {
    @objc optional func willMoveToPage(_ controller: UIViewController, index: Int)
    @objc optional func didMoveToPage(_ controller: UIViewController, index: Int)
}
class PageMenuController: UIViewController {
    enum PageMenuScrollDirection : Int {
        case left
        case right
        case other
    }
    var menuItems:[PageMenuItemView] = []
    var controllerArray:[UIViewController] = []
    var configuration = PageMenuViewConfig()
    let controllerScrollView = UIScrollView()
    let menuScrollView = UIScrollView()
    var startingMenuMargin : CGFloat = 0.0
    var pagesAddedDictionary : [Int : Int] = [:]
    var startingPageForScroll : Int = 0
    var lastPageIndex : Int = 0
    public var currentPageIndex : Int = 0
    var didTapMenuItemToScroll : Bool = false
    open weak var delegate : PageMenuControllerDelegate?
    var tapTimer : Timer?
    var didScrollAlready : Bool = false
    var lastScrollDirection : PageMenuScrollDirection = .other
    var lastControllerScrollViewContentOffset : CGFloat = 0.0
    var selectionIndicatorView : UIView = UIView()
    var menuItemWidths : [CGFloat] = []
    
    public  init(frame:CGRect, menuItems:[PageMenuItemView],controllers:[UIViewController],options:[PageMenuControllerOption]){
        super.init(nibName: nil, bundle: nil)
        view.frame = frame
        self.menuItems = menuItems
        controllerArray = controllers
        configurePageMenu(options: options)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLayoutSubviews() {
        setScrollViewContent()
    }
}

extension PageMenuController{
    func resetMenuItemLayout(itemsArrBlock:(_ items:[PageMenuItemView]) ->([PageMenuItemView])) {
        menuItems = itemsArrBlock(menuItems)
        setMenuItemLayout()
    }
    
    func addMenuItem(item:PageMenuItemView,controller:UIViewController) {
        menuItems.append(item)
        controllerArray.append(controller)
        menuItemWidths.append(item.config.menuItemWidth)
        for sub in menuScrollView.subviews {
            if sub is PageMenuItemView {
                sub.removeFromSuperview()
            }
        }
        setScrollViewContent()
        setMenuItemLayout()
        configSelectedMenuItem(index: currentPageIndex)
    }
    
    func removeMenuItem(index:Int) {
        removePageAtIndex(index)
        if index < menuItems.count {
            menuItems.remove(at: index)
            controllerArray.remove(at: index)
            menuItemWidths.remove(at: index)
        }
        for sub in menuScrollView.subviews {
            if sub is PageMenuItemView {
                sub.removeFromSuperview()
            }
        }
        setScrollViewContent()
        setMenuItemLayout()
        
        switch index {
        case 0:
            currentPageIndex = 1
            configSelectedMenuItem(index: 0)
            moveToPage(0)
            break
        case menuItems.count:
            currentPageIndex = index - 1
            configSelectedMenuItem(index: index - 1)
            moveToPage(index - 1)
            break
        default:
            currentPageIndex = index + 1
            configSelectedMenuItem(index: index)
            moveToPage(index)
            break
        }
    }
}

extension PageMenuController {
    func addPageAtIndex(_ index : Int) {
        if let currentController = controllerArray[safe: index], let  newVC = controllerArray[safe: index] {
            delegate?.willMoveToPage?(currentController, index: index)
            newVC.willMove(toParent: self)
            newVC.view.frame = CGRect(x: self.view.frame.width * CGFloat(index), y: 0.0, width: self.view.frame.width, height: self.view.frame.height - configuration.menuHeight)
            self.addChild(newVC)
            self.controllerScrollView.addSubview(newVC.view)
            newVC.didMove(toParent: self)
        }
    }
    
    func removePageAtIndex(_ index : Int) {
        if let oldVC = controllerArray[safe: index] {
            oldVC.willMove(toParent: nil)
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParent()
            oldVC.didMove(toParent: nil)
        }
    }
    
    func moveSelectionIndicator(_ pageIndex: Int) {
        if pageIndex >= 0 && pageIndex < controllerArray.count {
            UIView.animate(withDuration: 0.15, animations: { () -> Void in
                let selectionIndicatorWidth : CGFloat = self.selectionIndicatorView.frame.width
                self.selectionIndicatorView.frame = CGRect(x: 0, y: self.selectionIndicatorView.frame.origin.y, width: selectionIndicatorWidth, height: self.selectionIndicatorView.frame.height)
                if pageIndex < self.menuItems.count {
                    if let item   = self.menuItems[safe: pageIndex] {
                        self.selectionIndicatorView.center.x = item.center.x
                    }
                }
                if self.menuItems.count > 0 {
                    if let lastItem = self.menuItems[safe: self.lastPageIndex],let currentItem = self.menuItems[safe: self.currentPageIndex] {
                        lastItem.configureNormalState(config: lastItem.config)
                        currentItem.configureSelectedState(config: currentItem.config)
                    }
                }
            })
        }
    }
    open func moveToPage(_ index: Int) {
        if index >= 0 && index < controllerArray.count {
            if index != currentPageIndex {
                startingPageForScroll = index
                lastPageIndex = currentPageIndex
                currentPageIndex = index
                didTapMenuItemToScroll = true
                let smallerIndex : Int = lastPageIndex < currentPageIndex ? lastPageIndex : currentPageIndex
                let largerIndex : Int = lastPageIndex > currentPageIndex ? lastPageIndex : currentPageIndex
                if smallerIndex + 1 != largerIndex {
                    for i in (smallerIndex + 1)...(largerIndex - 1) {
                        if pagesAddedDictionary[i] != i {
                            addPageAtIndex(i)
                            pagesAddedDictionary[i] = i
                        }
                    }
                }
                addPageAtIndex(index)
                pagesAddedDictionary[lastPageIndex] = lastPageIndex
            }
            let duration : Double = Double(configuration.scrollAnimationDurationOnMenuItemTap) / Double(1000)
            UIView.animate(withDuration: duration, animations: { () -> Void in
                let xOffset : CGFloat = CGFloat(index) * self.controllerScrollView.frame.width
                self.controllerScrollView.setContentOffset(CGPoint(x: xOffset, y: self.controllerScrollView.contentOffset.y), animated: false)
            })
        }
    }
}
