//
//  HomeViewController.swift
//  DrinkDemo
//
//  Created by 林嫈沛 on 2019/4/16.
//  Copyright © 2019 lohaslab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let sweetArr = ["少糖","半糖","微糖","無糖"]
    let iceArr = ["多冰","少冰","去冰"]
    let sizeArr = ["大杯","中杯"]
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var DrinkTextField: UITextField!
    @IBOutlet weak var SweetSegmentedCtrl: UISegmentedControl!
    @IBOutlet weak var IceSegmentedCtrl: UISegmentedControl!
    @IBOutlet weak var SizeSegmentedCtrl: UISegmentedControl!
    @IBOutlet weak var GoBtn: UIButton!
    var picker = UIPickerView()     //產生picker
    var DrinkArr=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 30
        GoBtn.layer.cornerRadius = 30
        ActivityIndicator.isHidden=true
        DrinkArr=drinkdata() //撈菜單
        initPicker()

        // Do any additional setup after loading the view.
    }
    @IBAction func go(_ sender: Any) {
        if (NameTextField.text?.count)! > 0 , (DrinkTextField.text?.count)! > 0 , SweetSegmentedCtrl.selectedSegmentIndex >= 0 , IceSegmentedCtrl.selectedSegmentIndex >= 0 , SizeSegmentedCtrl.selectedSegmentIndex >= 0{
            let name = NameTextField.text!
            let drink = DrinkTextField.text!
            let sweet = sweetArr[SweetSegmentedCtrl.selectedSegmentIndex]
            let ice = iceArr[IceSegmentedCtrl.selectedSegmentIndex]
            let size = sizeArr[SizeSegmentedCtrl.selectedSegmentIndex]
            let todaysDate:NSDate = NSDate()
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyy-MM-dd HH:mm"
            let time:String = dateFormatter.string(from: todaysDate as Date)
            let orderDictionary:[String: Any] = ["name": name, "drink": drink, "sweet": sweet, "ice": ice, "size": size, "time": time]
            
            let orderData: [String: Any] = ["data": orderDictionary]
            print(orderData)
            self.ActivityIndicator.isHidden = false
            self.ActivityIndicator.startAnimating()
            
            Cdrink.Drink.upload(data: orderData, finished: {check in
                if check{
                    let Controller = UIAlertController(title: "訂單資料已送出", message: "謝謝您的訂購", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "確認", style: .default, handler: { (action) -> Void in
                        self.ActivityIndicator.stopAnimating()
                        self.ActivityIndicator.isHidden = true
                    })
                    Controller.addAction(okAction)
                    self.present(Controller, animated: true, completion: nil)
                }else{
                    let Controller = UIAlertController(title: "系統異常", message: "請再試一次", preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "確認", style: .default, handler: { (action) -> Void in
                        self.ActivityIndicator.stopAnimating()
                        self.ActivityIndicator.isHidden=true
                    })
                    Controller.addAction(okAction)
                    self.present(Controller, animated: true, completion: nil)
                }
            })
//            print(uploadStr)
        }else{
            //提醒alert
            let controller = UIAlertController(title: "訂購失敗", message: "有欄位沒有填到，要檢查清楚哦！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    }
    func initPicker(){    //初始化Picker
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        //設定代理人和資料來源為viewController
        picker.delegate = self
        picker.dataSource = self
        let doneButton = UIBarButtonItem(title: "確認", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.closeKeyboard))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        DrinkTextField.inputAccessoryView = toolBar
        //讓textfiled的輸入方式改為PickerView
        DrinkTextField.inputView = picker
        //加上手勢按鈕
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    // 飲料選項按下確定事件
    @objc func doneAction() {
        let row = picker.selectedRow(inComponent: 0)    //picker裡的選項
        DrinkTextField.text = DrinkArr[row]
        self.view.endEditing(true)
    }
    func drinkdata()->Array<String>{    //解析菜單
        if let asset = NSDataAsset(name: "可不可"), let content = String(data: asset.data, encoding: .utf8) {
            let array = content.components(separatedBy: "\n")
            print(array[0], array[1])
            return array
        }else{
            let array = [String]()
            return array
        }
    }
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {    //幾個區塊
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {  //幾列
        return DrinkArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DrinkArr[row]    //顯示內容
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == .motionShake { //是否為搖晃手機的事件
            let randomNum = Int(arc4random()) % DrinkArr.count
            //let tmpDic = DrinkArr[randomNum]
            //print("shanking now - \(tmpDic["drinkShowString"]!)")
            picker.selectRow(randomNum, inComponent: 0, animated: true)
            //drinkTextField.text = tmpDic["drinkShowString"]!
        }
    }

}
