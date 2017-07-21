//
//  ViewController.swift
//  Swift3手机号输入框
//
//  Created by tongqu on 2017/7/11.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

class ViewController: UIViewController//,UITextFieldDelegate
{

    //保存上次的文本内容
//    var _previousText:String!
//    //保存上次的文本范围
//    var _previousRange:UITextRange!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let _rect:CGRect = CGRect(x: 30, y: 80, width: 200, height: 50)
//        let phoneField = UITextField(frame: .zero)
//        phoneField.frame = _rect
//        
//        phoneField.borderStyle = .roundedRect
//        phoneField.keyboardType = .numberPad
//        phoneField.delegate = self
//        phoneField.addTarget(self, action: #selector(phoneNumberFormat(_:)), for: .editingChanged)
//        self.view.addSubview(phoneField)
        
        
        let customPhoneTF = ZEPhoneField(frame: CGRect(x: 40, y: 160, width: 300, height: 30))
            
        self.view.addSubview(customPhoneTF)
        
        
        
        
    }
 
//    //输入框内容改变时对其内容做格式化处理
//    func phoneNumberFormat(_ textField: UITextField) {
//        //1、获取当前光标的位置（后面会对其进行修改）
//        var cursorPostion = textField.offset(from: textField.beginningOfDocument, to: textField.selectedTextRange!.start)
//        
//        //2、过滤掉非数字字符，只保留数字
//        var digistsText = getDigitsText(string: textField.text!, cursorPosition: &cursorPostion)
//        
//        //3、避免超过11位的输入
//        if digistsText.characters.count > 11 {
//            textField.text = _previousText
//            textField.selectedTextRange = _previousRange
//            return
//        }
//        
//        //4、得到带有分隔符的字符串
//        let hyphenText = getHyphenText(string: digistsText, cursorPosition: &cursorPostion)
//        
//        //5、将最终带有分隔符的字符串显示在textfield上
//        textField.text = hyphenText
//        
//        //6、让光标停留在正确的位置上
//        let targetPosition = textField.position(from: textField.beginningOfDocument, offset: cursorPostion)!
//        textField.selectedTextRange = textField.textRange(from: targetPosition, to: targetPosition)
//        
//        
//    }
//    
//    //去除非数字字符，同时记录光标正确位置 关键字：inout-让值类型以引用方式传递http://www.jianshu.com/p/6b858cb0b55d
//    func getDigitsText(string:String,cursorPosition:inout Int) -> String {
//        //保存开始时光标的位置
//        let originCursorPosition = cursorPosition
//        
//        //处理后的结果字符串
//        var result = ""
//        
//        var i = 0
//        
//        //遍历每个字符串
//        for unChar in string.unicodeScalars {
//            //如果是数字则添加到返回结果中
//            if CharacterSet.decimalDigits.contains(unChar) {
//                result.append(string[i])
//            }
//            //非数字则跳过，如果非法字符在光标位置之前，则光标需要向前移动
//            else {
//                if i < originCursorPosition {
//                    cursorPosition = cursorPosition - 1
//                }
//            }
//            
//            i += 1
//        }
//        
//        return result
//        
//    }
//    
//    //将分隔符插入现在的string中，同时确定光标正确位置
//    func getHyphenText(string:String, cursorPosition:inout Int) -> String {
//        //保存开始时光标的位置
//        let originalCursorPosition = cursorPosition
//        //处理后的结果字符串
//        var result = ""
//        
//        for i in 0 ..< string.characters.count {
//            if i==3 || i==7 {
//                result.append("-")
//                if i < originalCursorPosition {
//                    cursorPosition += 1
//                }
//            }
//            result.append(string[i])
//        }
//        return result
//    }
//    
//    
//    //该方法就能在文本框将要变化的时候执行一些代码
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //先保存输入框原先的值和选中范围
//        _previousText = textField.text!
//        _previousRange = textField.selectedTextRange!
//        //输入的第一个数字必需为1
//        if range.location == 0 {
//            
//            guard !string.isEmpty else {
//                return true
//            }
//            if (string as NSString).intValue != 1 {
//                return false
//            }
//        }
//        
//        return true
//    }

}

//通过对String扩展，字符串增加下表索引功能
//extension String
//{
//    subscript(index:Int) -> String
//    {
//        get{
//            return String(self[self.index(self.startIndex, offsetBy: index)])
//        }
//        set{
//            let temp = self
//            self = ""
//            
//            for (idx, item) in temp.characters.enumerated() {
//                if idx == index {
//                    self += "\(newValue)"
//                } else {
//                    self += "\(item)"
//                }
//            }
//            
//        }
//    }
//}
