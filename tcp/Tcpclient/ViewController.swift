//
//  ViewController.swift
//  Tcpclient
//
//  Created by 徐琮淋 on 2022/7/22.
//

import UIKit
import CocoaAsyncSocket
import DropDown

var droptext = "協助者"


class ViewController: UIViewController, GCDAsyncSocketDelegate {
    
    var socket: GCDAsyncSocket!
    
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var groupname: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dropBtn: UIButton!
    let dropDown = DropDown()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //建立TCP Socket
        socket = GCDAsyncSocket(delegate: self,delegateQueue:DispatchQueue.main)
        
        
    }
    //下拉式選單
    @IBAction func tapChooseMenuItem(_ sender: UIButton) {//3
        dropDown.dataSource = ["協助者", "求助者", "觀看者"]//4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal) //9
            droptext = item
            
            if(item == "協助者")
            {
                print("hello")
            }
            if(item == "求助者")
            {
                print("hello2")
            }

            if(item == "觀看者")
            {
                print("hello3")
            }
             
            //droptext = item
            
                
            
        }
        
        
      }
    //傳輸與bind
    @IBAction func sendBtn(_ sender:Any)
    {
        sendBtn.isSelected = !sendBtn.isSelected
        //選擇按鈕時則進行連線，取消選擇時則中止連線
        //sendBtn.isSelected ? connect() : stopConnect()
        connect()
        //將輸入的文字轉為data格式
        let addresstext = addressTextField.text
        let porttext = portTextField.text
        let token = "Token=\n"
        //let grouptext = groupname.text
        let groupdata1 = "Group_Name="
        let groupdata2 = "\n"
        let account = "Account=\n"
        let passwd = "Password=\n"
        let role = "Role="
        let top = "{{{\n"
        let down = "}}}\n"
        //let total = "{{{\nToken=\nGroup_Name=test\nAccount=\nPassword=\nRole=V\n}}}\n"
        let testgroup :String = groupname.text!
       
        
        if((addresstext != "") && (porttext != "") && (droptext == "觀看者"))
        {
        
            let chartext = "V\n"
            let testtotal = top + token + groupdata1 + testgroup + groupdata2 + account + passwd + role + chartext + down
          
           /* let data1 = token.data(using: .utf8)
            let data2 = chartext.data(using: .utf8)
            let data3 = groupdata1.data(using: .utf8)
            //let data4 = grouptext?.data(using: .utf8)
            let data5 = groupdata2.data(using: .utf8)
            let data6 = account.data(using: .utf8)
            let data7 = passwd.data(using: .utf8)
            let data8 = top.data(using: .utf8)
            let data9 = role.data(using: .utf8)
            let data10 = down.data(using: .utf8)
            */
            let total = testtotal.data(using: .utf8)
            socket.write(total!, withTimeout: -1, tag: 0)
            /*
            socket.write(data8!, withTimeout: -1, tag: 0)
            socket.write(data1!, withTimeout: -1, tag: 0)
            socket.write(data3!, withTimeout: -1, tag: 0)
            socket.write(data4!, withTimeout: -1, tag: 0)
            socket.write(data5!, withTimeout: -1, tag: 0)
            socket.write(data6!, withTimeout: -1, tag: 0)
            socket.write(data7!, withTimeout: -1, tag: 0)
            socket.write(data9!, withTimeout: -1, tag: 0)
            socket.write(data2!, withTimeout: -1, tag: 0)
            socket.write(data10!, withTimeout: -1, tag: 0)
             */
            
            view.endEditing(true)
            //清空輸入
            
           // groupname.text = ""
            
            //切換到watch view
            
            DispatchQueue.main.async
            {
                self.performSegue(withIdentifier:"watch", sender: self)
            }
             
            stopConnect()
             
             
        }
        else if((addresstext != "") && (porttext != "") && (droptext == "協助者"))
        {
            let chartext = "A\n"
            let testtotal = top + token + groupdata1 + testgroup + groupdata2 + account + passwd + role + chartext + down
          /*
            let data1 = token.data(using: .utf8)
            let data2 = chartext.data(using: .utf8)
            let data3 = groupdata1.data(using: .utf8)
            let data4 = grouptext?.data(using: .utf8)
            let data5 = groupdata2.data(using: .utf8)
            let data6 = account.data(using: .utf8)
            let data7 = passwd.data(using: .utf8)
            let data8 = top.data(using: .utf8)
            let data9 = role.data(using: .utf8)
            let data10 = down.data(using: .utf8)
           */
            
            let total = testtotal.data(using: .utf8)
            socket.write(total!, withTimeout: -1, tag: 0)
            /*
            socket.write(data8!, withTimeout: -1, tag: 0)
            socket.write(data1!, withTimeout: -1, tag: 0)
            socket.write(data3!, withTimeout: -1, tag: 0)
            socket.write(data4!, withTimeout: -1, tag: 0)
            socket.write(data5!, withTimeout: -1, tag: 0)
            socket.write(data6!, withTimeout: -1, tag: 0)
            socket.write(data7!, withTimeout: -1, tag: 0)
            socket.write(data9!, withTimeout: -1, tag: 0)
            socket.write(data2!, withTimeout: -1, tag: 0)
            socket.write(data10!, withTimeout: -1, tag: 0)
             */

            view.endEditing(true)
            //清空輸入
            
            groupname.text = ""
            
            //切換到stream view
            
            DispatchQueue.main.async
            {
                self.performSegue(withIdentifier:"stream", sender: self)
            }
             
            stopConnect()
             
        }
        else if((addresstext != "") && (porttext != "") && (droptext == "求助者"))
        {
            let chartext = "H\n"
            let testtotal = top + token + groupdata1 + testgroup + groupdata2 + account + passwd + role + chartext + down
            /*
            let data1 = token.data(using: .utf8)
            let data2 = chartext.data(using: .utf8)
            let data3 = groupdata1.data(using: .utf8)
            let data4 = grouptext?.data(using: .utf8)
            let data5 = groupdata2.data(using: .utf8)
            let data6 = account.data(using: .utf8)
            let data7 = passwd.data(using: .utf8)
            let data8 = top.data(using: .utf8)
            let data9 = role.data(using: .utf8)
            let data10 = down.data(using: .utf8)
            */
            let total = testtotal.data(using: .utf8)
            socket.write(total!, withTimeout: -1, tag: 0)
            /*
            socket.write(data8!, withTimeout: -1, tag: 0)
            socket.write(data1!, withTimeout: -1, tag: 0)
            socket.write(data3!, withTimeout: -1, tag: 0)
            socket.write(data4!, withTimeout: -1, tag: 0)
            socket.write(data5!, withTimeout: -1, tag: 0)
            socket.write(data6!, withTimeout: -1, tag: 0)
            socket.write(data7!, withTimeout: -1, tag: 0)
            socket.write(data9!, withTimeout: -1, tag: 0)
            socket.write(data2!, withTimeout: -1, tag: 0)
            socket.write(data10!, withTimeout: -1, tag: 0)
             */
            view.endEditing(true)
            //清空輸入
            
            groupname.text = ""
            
            //切換到stream view
            /*
            DispatchQueue.main.async
            {
                self.performSegue(withIdentifier:"watch", sender: self)
            }
             
            stopConnect()
             */
             
        }
        
        
    }
    
  /*  @IBAction func connectBtn(_ sender: Any)
    {
        //設定按鈕選擇與取消選擇
        bindBtn.isSelected = !bindBtn.isSelected
        //選擇按鈕時則進行連線，取消選擇時則中止連線
        bindBtn.isSelected ? connect() : stopConnect()
        
        if bindBtn.isSelected
        {
            //選擇按鈕後著上灰色
            self.bindBtn.tintColor = UIColor.gray
        }
        else
        {
            self.bindBtn.tintColor = UIColor.systemBlue
        }
    }
   */
    //建立連線
    func connect()
    {
        sendBtn.setTitle("send", for: .normal)
        
        do{
            //綁定在addressTextField與portTextField上所輸入的資料
            try socket.connect(toHost: addressTextField.text!, onPort: UInt16(portTextField.text!)!, withTimeout: -1)
            print("success")
        }
        catch{
            print("test")
            stopConnect()
            //新增彈跳式的提示視窗
            let alertController = UIAlertController(title: "連結失敗!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            showMessage("連線狀態：連線失敗")
        }
        view.endEditing(true)
    }
    //中止連線
    func stopConnect()
    {
       // bindBtn.setTitle("Bind", for: .normal)
        socket.disconnect()
        
    }
    
    
    
    
    //清除Textview上的資料
    @IBAction func clearBtn(_ sender:Any)
    {
        //messageTextField.text = ""
        messageTextView.text = ""
    }
    
     
    
    //在Textview上顯示訊息
    func showMessage(_ str:String)
    {
        messageTextView.text = messageTextView.text.appendingFormat("%@\n",str )
    }
    //連接成功後，在Textview上會顯示連接成功的訊息以其server IP
    func socket(_ sock: GCDAsyncSocket ,didConnectToHost host:String,port:UInt16)
    {
            showMessage(dateString())
        
            showMessage("連線狀態：連線成功")
        
            let address = "Server IP: " + "\(host)"
        
            showMessage(address)
        
            showMessage("------------------")
        
            socket.readData(withTimeout: -1, tag: 0)
    }
    //接收從server的回傳的訊息
    func socket(_ sock: GCDAsyncSocket,didRead data: Data ,withTag tag:Int)
    {
        let text = String(data:data ,encoding: .utf8)
        //let url = text
       
        showMessage(dateString() + "\nServer:" + text! + "\n")
        
        socket.readData(withTimeout: -1, tag: 0)
        
    }
    //獲取目前時間，並且轉換成String
    func dateString() -> String
    {
        let now = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.string(from:now)
        
        return date
        
    }
    func closekeyboard(){
            self.view.endEditing(true)
        }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            closekeyboard()
        }


}

