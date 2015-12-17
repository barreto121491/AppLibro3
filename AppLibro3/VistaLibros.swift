//
//  VistaLibros.swift
//  AppLibro3
//
//  Created by Arturo Barreto Villafán on 12/7/15.
//  Copyright © 2015 Arturo Barreto Villafán. All rights reserved.
//

import UIKit

class VistaLibros: UIViewController {

    @IBOutlet weak var txtAutor: UILabel!
    @IBOutlet weak var txtTitulo: UILabel!
    
    @IBOutlet weak var portada: UIImageView!
    var ISBN = ""
    
    var libs : Libro?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (libs != nil){
            
        txtAutor.text = libs!.autor
        txtTitulo.text = libs!.titulo
        portada.image = libs!.portada
        
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

   
    
    
    
}
