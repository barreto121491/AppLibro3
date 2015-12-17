//
//  Search.swift
//  AppLibro3
//
//  Created by Arturo Barreto Villafán on 12/16/15.
//  Copyright © 2015 Arturo Barreto Villafán. All rights reserved.
//

import UIKit

class Search: UIViewController {
    var libros : Libro?
    var vistaP : TablaLibros? = nil ;
    
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var buscarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        autor.text = libros?.autor
        titulo.text = libros?.titulo
        portada.image = libros?.portada
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
  

    @IBAction func search(sender: UIButton) {
        
        
        buscar(buscarTextField)
        
        
    }
    
    func buscar (sender: UITextField) {
        if vistaP != nil {
            let new = vistaP!.Libros(sender.text!)
            if new != nil {
                vistaP!.nuevoLibro(new!)
                self.libros = new
                autor.text = libros?.autor
                titulo.text = libros?.titulo
                portada.image = libros?.portada
                print(new)
            }
            sender.text = nil 
        }
    }
    }
