//
//  SecondViewController.swift
//  program
//
//  Created by Abylaikhan Koshanov on 3/5/20.
//  Copyright © 2020 Abylaikhan Koshanov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
             super.viewDidLoad()
        
         }
    var selectCol: UIColor?
    var sFigure: UIView?
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    
     @IBOutlet var buttons: [UIButton]!
    
    
    
    @IBAction func colorButton(_ sender: UIButton) {

        if sender.titleLabel?.text == "red" {
                  selectCol=sender.backgroundColor
            
              } else if sender.titleLabel?.text == "blue"{
                  selectCol=sender.backgroundColor
            
              } else if sender.titleLabel?.text == "purple" {
                  selectCol=sender.backgroundColor
            
              } else {
                  selectCol=sender.backgroundColor
              }
        
    }
    

    
    var parameters: ((_ width: Double, _ height: Double, _ x: Double, _ y: Double, _ color: UIColor) -> Void)? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
        openViewData()
        configureNav()
        
    }
    
    @objc func deleteFigure() {
           guard let figure = sFigure else {return}
           figure.removeFromSuperview()
           self.navigationController?.popViewController(animated: true)
       }
    
    @objc func saveFigure() {
       guard let width = widthTextField.text, let height = heightTextField.text, let x = xTextField.text, let y = yTextField.text, let color = selectCol else {
                 let alert = UIAlertController(title: "OK", message: "dara neredesin", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(alert, animated: true)
                 return
             }
             
             guard let width_new = Double(width), let heightNew = Double(height), let xNew = Double(x), let yNew = Double(y) else {
                 return
             }
             
             guard let sFigure = sFigure else {
                 parameters?(width_new, heightNew, xNew, yNew, color)
                 self.navigationController?.popViewController(animated: true)
                 return
             }
             
        sFigure.backgroundColor = selectCol
        sFigure.frame = CGRect(x: CGFloat(xNew), y: CGFloat(yNew), width: CGFloat(width_new), height: CGFloat(heightNew))
             
             self.navigationController?.popViewController(animated: true)
    }
    
    func configureNav (){
        let deleteButton = UIBarButtonItem(title:"delete", style: .plain, target: self, action: #selector(deleteFigure))
        let addButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveFigure))
        
        guard sFigure != nil else {
             navigationItem.rightBarButtonItems = [ addButton]
            return
        }
        navigationItem.rightBarButtonItems = [deleteButton, addButton]
    }
    
    func openViewData(){
         guard let figure = sFigure else{return}
         print(figure.frame.width)
         self.widthTextField.text = figure.frame.width.description
         self.heightTextField.text = figure.frame.height.description
         self.xTextField.text = figure.frame.origin.x.description
         self.yTextField.text = figure.frame.origin.y.description
     }
}
