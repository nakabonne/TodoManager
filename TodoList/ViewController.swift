//
//  ViewController.swift
//  TodoList
//
//  Created by 中尾涼 on 2017/07/09.
//  Copyright © 2017年 中尾涼. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoList = [String]()
    // テーブル
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // todoの読み込み
        let userDefaults = UserDefaults.standard
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todoList.append(contentsOf: storedTodoList)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // +ボタンを押した時
    @IBAction func tapAddButton(_ sender: Any){
        // アラートダイアログを生成
        let alertController = UIAlertController(title: "TODO追加", message: "TOODを入力して下さい", preferredStyle: UIAlertControllerStyle.alert)
        
        // テキストエリアを追加
        alertController.addTextField(configurationHandler: nil)
        
        // OKボタンを追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            //OKボタンが押された時
            if let textField = alertController.textFields?.first {
                // TODOの配列の戦闘に入力値を入れる
                self.todoList.insert(textField.text!, at: 0)
                
                // テーブルに行が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.right)
                
                // todoの保存処理
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.todoList, forkey: "todoList")
                userDefaults.synchronize()
            }
        }
        
        
        // OKボタン追加
        alertController.addAction(okAction)
        
        // キャンセルボタンが押された時
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler: nil)
        
        // キャンセルボタン追加
        alertController.addAction(cancelButton)
        
        // アラートダイアログを表示
        present(alertController, animated: true, completion: nil)
    }
    
    
    // テーブルの行数を返却する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todoの配列の長さを返却する
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // storyboardで指定したtodoCell識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        // 行番号のあったtodoのタイトルを取得
        let todoTitle = todoList[indexPath.row]
        //セルのラベルにtodoのタイトルをセット
        cell.textLabel?.text = todoTitle
        return cell
    }
    


}

