//
//  SideMenuViewController.swift
//  TableView
//
//  Created by tongqu on 2017/6/28.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    var exmpleIndex = 0 //arc4random() % 4
    
    var sideMenu:TQSideMenu?
    
    //MARK: - life cyele
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        switch exmpleIndex {
        case 0:
            view.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255, green: CGFloat(arc4random()%256)/255, blue: CGFloat(arc4random()%256)/255, alpha: 1)
        case 1:
            initSideMenuView()
        default:
            break
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func initSideMenuView() {
        
        // "_"：表示忽略外部参数  "?"：表示变量是option变量 "!":表示确定变量是有值的，可直接解包使用（如果没值回报错）
        let titles = ["推荐","要闻","视频","河南","环球日报","财经","科技","人文社科","娱乐","健康","文学","世说新语"]//,"财经","科技","人文社科","娱乐","健康","文学","世说新语"
        var ary:Array<UIViewController> = []
        
        for _ in 0 ..< titles.count {
            let vc = SideMenuViewController()
            self.addChildViewController(vc)
            ary.append(vc)
        }
        
        let rect:CGRect = CGRect(x: 0, y: 64, width: view.frame.width, height: 40)
        sideMenu = TQSideMenu(frame: rect, titles: titles, childControllers: ary)
        sideMenu?.unSelectedColor = UIColor.gray
        sideMenu?.indicatorStyle = .stretch
        sideMenu?.titleStyle = .transfrom
    
        view.addSubview(sideMenu!)
        
    }
    
}
