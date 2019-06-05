//
//  ViewController.swift
//  Citi
//
//  Created by gino tarraga on 2/25/19.
//  Copyright © 2019 gino tarraga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var Register: UIButton!
    //@IBOutlet weak var logIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
    Register.layer.cornerRadius = 8
    //logIn.layer.cornerRadius = 10
        
    }

}
/*
extension UIView {
    func anchor (top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor,
                 bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor ) {
        
        translatesAutoresizingMaskIntoConstraints = false
       
        topAnchor.constraint(equalTo: top).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
        trailingAnchor.constraint(equalTo: trailing).isActive = true
        
    }
}
*/
