//
//  ViewController.swift
//  Tcpclient
//
//  Created by 徐琮淋 on 2022/7/22.
//

import UIKit
import CocoaAsyncSocket

class ViewController: UIViewController, GCDAsyncSocketDelegate {
    
    var socket: GCDAsyncSocket!
    
   // @IBOutlet weak var bindBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var character: UITextField!
    @IBOutlet weak var groupname: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //建立TCP Socket
        socket = GCDAsyncSocket(delegate: self,delegateQueue:DispatchQueue.main)
        
    }
    
    /*@IBAction func connectBtn(_ sender: Any)
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
        
    }*/
    //建立連線
    func connect()
    {
     //   bindBtn.setTitle("Unbind", for: .normal)
        
        do{
            //綁定在addressTextField與portTextField上所輸入的資料
            try socket.connect(toHost: addressTextField.text!, onPort: UInt16(portTextField.text!)!, withTimeout: -1)
        }
        catch{
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
    
    
    @IBAction func sendBtn(_ sender:Any)
    {
        sendBtn.isSelected = !sendBtn.isSelected
        //選擇按鈕時則進行連線，取消選擇時則中止連線
        sendBtn.isSelected ? connect() : stopConnect()
        //將輸入的文字轉為data格式
        let addresstext = addressTextField.text
        let porttext = portTextField.text
        let charactertext = character.text
        let grouptext = groupname.text
        
        if((addresstext != "") && (porttext != "") && (charactertext == "H"))
        {
            let data1 = character.text?.data(using: .utf8)
            
            showMessage(dateString()+"\nCharacter: " + character.text! + "\n")
            socket.write(data1!, withTimeout: -1, tag: 0)
            
            let data2 =  groupname.text?.data(using: .utf8)
            
            showMessage(dateString()+"\ngruopname: " + groupname.text! + "\n")
            socket.write(data2!, withTimeout: -1, tag: 0)
            //socket.write(grouptext!, withTimeout: -1, tag: 0)
            view.endEditing(true)
            //清空輸入
            character.text = ""
            groupname.text = ""
            
            //切換到watch view
            /*
            DispatchQueue.main.async
            {
                self.performSegue(withIdentifier:"watch", sender: self)
            }
             */
        }
        else if((addresstext != "") && (porttext != "") && (charactertext == "A"))
        {
            let data1 = character.text?.data(using: .utf8)
            
            showMessage(dateString()+"\nCharacter: " + character.text! + "\n")
            socket.write(data1!, withTimeout: -1, tag: 0)
            
            let data2 = groupname.text?.data(using: .utf8)
            
            showMessage(dateString()+"\ngruopname: " + groupname.text! + "\n")
            socket.write(data2!, withTimeout: -1, tag: 0)
            view.endEditing(true)
            
            //清空輸入
            character.text = ""
            groupname.text = ""
            
            //切換到stream view
            /*
            DispatchQueue.main.async
            {
                self.performSegue(withIdentifier:"stream", sender: self)
            }
            */
        }
        
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

