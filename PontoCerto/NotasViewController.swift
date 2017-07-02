//
//  NotasViewController.swift
//  PontoCerto
//
//  Created by Leonardo Santos on 02/07/17.
//  Copyright © 2017 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class NotasViewController  : UIViewController
{
    
    @IBOutlet weak var NomeDisciplinaLabel: UILabel!
    
    var nomeDisciplina : String! = nil
    
    
    public func alteraNome(nome : String)
    {
        nomeDisciplina = nome;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NomeDisciplinaLabel.text = nomeDisciplina;
        
        self.title = "Notas"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
