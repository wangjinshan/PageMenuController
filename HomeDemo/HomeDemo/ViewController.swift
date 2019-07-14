//
//  ViewController.swift
//  HomeDemo
//
//  Created by 山神 on 2019/7/10.
//  Copyright © 2019 山神. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var controllerArray : [UIViewController] = []
    let parameters: [CAPSPageMenuOption] = [
        .scrollMenuBackgroundColor(UIColor.white),
        .viewBackgroundColor(UIColor.white),
        .selectionIndicatorColor(UIColor.red), //指示器颜色
        .selectedMenuItemLabelColor(UIColor.green),
        .unselectedMenuItemLabelColor(UIColor.cyan), //未选中的颜色
        .bottomMenuHairlineColor(UIColor.white),
        .menuItemFont(UIFont.systemFont(ofSize: 14)),
        .menuHeight(44),
//        .menuItemWidthBasedOnTitleTextWidth(true),
        .centerMenuItems(true)
//        .menuMargin(15),
//        .menuItemMargin(66)
    ]
    let Avc = AViewController()
    let Bvc = BViewController()
    let Cvc = CViewController()
    let Dvc = DViewController()
    let FVc = FViewController()


    var pageMenu : CAPSPageMenu?
    var pageMenuController : PageMenuController?
    
      let vc = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customPageMenu()
//        sdkPageMenu()
    }
}

extension ViewController{
    func customPageMenu()  {
        
        let item1 = PageMenuItemView(options: [.menuItemTitle("牛逼1"),.menuItemHeight(34),.menuItemWidth(66)])
        let item2 = PageMenuItemView(options: [.menuItemTitle("牛逼2"),.menuItemHeight(34),.menuItemWidth(66)])
        
        let item3 = PageMenuItemView(options: [.menuItemTitle("牛逼3"),.menuItemHeight(34),.menuItemWidth(66)])
        
        let item4 = PageMenuItemView(options: [.menuItemTitle("牛逼4"),.menuItemHeight(34),.menuItemWidth(66)])
        
        let item5 = PageMenuItemView(options: [.menuItemTitle("牛逼5"),.menuItemHeight(34),.menuItemWidth(66)])
        
        let item6 = PageMenuItemView(options: [.menuItemTitle("牛逼6"),.menuItemHeight(34),.menuItemWidth(66)])
        
        let item7 = PageMenuItemView(options: [.menuItemTitle("牛逼7"),.menuItemHeight(34),.menuItemWidth(66)])
        
        let options:[PageMenuControllerOption] = []
        pageMenuController =  PageMenuController(frame: CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height), menuItems: [item1,item2,item3,item4,item5,item6,item7], controllers: [AViewController(),BViewController(),CViewController(),DViewController(),EViewController(),FViewController(),GViewController()], options: options)
        
        view.addSubview(pageMenuController!.view)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            
//            self.pageMenuController?.resetMenuItemLayout(itemsArrBlock: { (itemsArr) -> ([PageMenuItemView]) in
//                let item = itemsArr.first
//                item?.layoutItem(title: "哈哈", icon: "jinhangzhong")
//                
//                let item3 =  itemsArr[2]
//                item3.layoutItem(title: "牛逼", icon: "")
//                
//                return itemsArr
//            })
//        }
    }
    
    func sdkPageMenu()  {
        controllerArray.append(Avc)
        controllerArray.append(Bvc)
        controllerArray.append(Cvc)
        controllerArray.append(Dvc)
        controllerArray.append(FVc)
        
        Avc.title = "全部"
        Bvc.title =  "打卡      "
        Cvc.title = "活动"
        Dvc.title = "讨论"
        FVc.title = "调查"
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 64, width: view.frame.width, height: view.frame.height), pageMenuOptions: parameters)
        view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParent: self)
        
        let itemView =  pageMenu?.menuItems[1]
        let label =  itemView?.titleLabel
        label?.attributedText = createAttributedText(title: "打卡")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.Dvc.title = "讨论      "
            self.pageMenu?.view.removeFromSuperview()
            self.pageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: CGRect(x: 0.0, y: 64, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: self.parameters)
            self.view.addSubview(self.pageMenu!.view)
            
            let itemView =  self.pageMenu?.menuItems[3]
            let label =  itemView?.titleLabel
            label?.attributedText = self.createAttributedText(title: "讨论")
        }
    }

}

extension ViewController {
    func createAttributedText(title:String) -> NSAttributedString {
        let attri = NSMutableAttributedString(string: title)
        let attch = NSTextAttachment()
        attch.image = UIImage(named: "jinhangzhong")
        attch.bounds = CGRect(x: 3, y: 0, width: 20, height: 14)
        let string = NSAttributedString(attachment: attch)
        attri.append(string)
        return attri
    }
}
