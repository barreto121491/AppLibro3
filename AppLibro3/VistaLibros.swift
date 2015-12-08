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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libro(ISBN)
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

    func libro(ISBN : String){
        
        let ISBN = ISBN
        let urlh = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urlh+ISBN)
        let datos : NSData? = NSData(contentsOfURL: url!)
        if datos == nil{
            let alercontroller = UIAlertController(title: nil, message: "Error en la Red", preferredStyle: UIAlertControllerStyle.Alert)
            alercontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: nil))
            
            self.presentViewController(alercontroller, animated: true, completion: nil)
            
        }
        else{
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableContainers)
                let dico = json as! NSDictionary
                let dico1 = dico["ISBN:"+ISBN]
                if (dico1 != nil && dico1 is NSDictionary){
                    let dico2  = dico1 as! NSDictionary
                    print(dico2["title"])
                    
                    txtTitulo.text = dico2["title"] as! NSString as String
                    if (dico2["cover"] == nil){
                        //portada.text = "no hay portada"
                        portada.image = nil
                        
                    }
                    else{
                        let dico3 = dico2["cover"] as! NSDictionary
                        let img_urls = dico3["medium"] as! String
                        let img_url = NSURL(string: img_urls)
                        let img_datos = NSData(contentsOfURL: img_url!)
                        portada.image = UIImage(data: img_datos!)
                        
                        
                        
                        
                    }
                    // digo que dico3 es un array por los corchetes que nos muestra en el json
                    
                    
                    let dico3 = dico2["authors"] as! NSArray
                    
                    
                   
                    
                    // recorremos el arreglo buscando la posiciion de "name " que corresponde al nombre
                    for (var i = 0; i < dico3.count; i++ ){
                        let autores = dico3[i] as! NSDictionary
                        print(autores["name"])
                        txtAutor.text = autores["name"] as! NSString as String
                        
                        print(dico3[i])
                        
                    }
                    
                    
                }
                else{
                    let alercontroller = UIAlertController(title: nil, message: "No Existe ese Libro", preferredStyle: UIAlertControllerStyle.Alert)
                    alercontroller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: nil))
                    
                    self.presentViewController(alercontroller, animated: true, completion: nil)
                }
                
            }
            catch _ {
                
                
            }
        }
        
    }
    
    
    
}
