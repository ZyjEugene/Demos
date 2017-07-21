//
//  ViewController.swift
//  TableView
//
//  Created by tongqu on 2017/6/20.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//  swift 3.0 学习练习

import UIKit



class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK:- 声明全局变量
    var demos :NSArray?
    var titles :NSArray?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        getDemoTitles()

        getTableView()
        
         // Do any additional setup after loading the view, typically from a nib.
    }
   
    //MARK:- 创建表
    func getTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-20))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView.init()
        self.view.addSubview(tableView)
    }
    
    //MARK:- 获取系统字体
    func getDemoTitles() {
        let titles: NSArray?
        let demos: NSArray?
        titles = ["Swift3.0 简单的tableView练习",
                  "Swift3.0 tableView单元格高度自适应",
                  "Swift3.0 tableView单元格图片高度自适应",
                  "Swift3.0 SideMenu",
                  "Swift3.0 DataConvertedBytes"]
        demos = ["SimpleViewController",
                  "AdaptionCellViewController",
                  "CustomCellViewController",
                  "SideMenuViewController",
                  "DataConvertedBytesViewController"]
        self.titles = titles
        self.demos = demos
    }

    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIndentifier)
        }
        
        cell?.textLabel?.text = self.titles?[indexPath.row] as? String
        //cell?.selectionStyle = .none
        
        return cell!
    }
 
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 3 {
            let className: String = self.demos?[indexPath.row] as! String
            
            let viewClass = stringClassObjectFromString(className: className)
            navigationController?.pushViewController(viewClass!, animated: true)
            
        } else {
            let viewController = SideMenuViewController()
            viewController.exmpleIndex = 1
            navigationController?.pushViewController(viewController, animated: true)
        }

        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 1)!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("index.row = editingStyle第\(indexPath.row)行")
    }
    
    // MARK:
    // MARK: 字符串转换成类,返回其对象
    /// 字符串转换成类,返回其对象
    func stringClassObjectFromString(className: String) -> UIViewController! {
        
        // 1.获取命名空间
        // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
//        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
//            print("命名空间不存在")
//            return nil
//        }
//        // 2.通过命名空间和类名转换成类
//        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + className)
//        
//        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
//        guard let clsType = cls as? UIViewController.Type else {
//            print("无法转换成UIViewController")
//            return nil
//        }
//        // 3.通过Class创建对象
//        let childController = clsType.init()
//        childController.view.backgroundColor = UIColor.white
//        return childController
        
        /// 获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        /// 根据命名空间传来的字符串先转换成anyClass
        let anyClass: AnyClass = NSClassFromString(namespace + "." + className)!
        
        /// 确定控制器类型
        let type = anyClass as! UIViewController.Type
        
        /// 根据类型创建相关对象
        let vcClass = type.init()
        vcClass.view.backgroundColor = UIColor.white
        
        /// 返回这个类的对象
        return vcClass
    }
}

