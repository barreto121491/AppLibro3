//
//  TablaLibros.swift
//  AppLibro3
//
//  Created by Arturo Barreto Villafán on 12/6/15.
//  Copyright © 2015 Arturo Barreto Villafán. All rights reserved.
//

import UIKit



class TablaLibros: UITableViewController {
    
   
    var image : UIImage = UIImage(named:"404")!

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    var libros : [Libro] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // libro de ejemplo
       
            libros.append(Libros("9788497364676")!)
        
        
       
        
       
        
        
        // Uncomment the autoresfollowing line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.libros.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = libros[indexPath.row].titulo
        cell.imageView?.image = libros[indexPath.row].portada
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cc =  segue.destinationViewController
        
        
        if cc is VistaLibros {
            let detalle = segue.destinationViewController as! VistaLibros
            
            let ip = self.tableView.indexPathForSelectedRow
            
            detalle.libs = libros[ip!.row]
        } else if cc is Search {
            let detalle = segue.destinationViewController as! Search
            detalle.libros = nil
            detalle.vistaP = self
        }
    }
   
    
    func Libros(isbn : String) -> Libro? {
        
        
        let libro : Libro = Libro (isbn: isbn)
        //var libr: [String] = []
        let ISBN = isbn
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
                    // print(dico2["title"])
                    
                    libro.titulo = dico2["title"] as! NSString as String
                    //libr.append(dico2["title"] as! String)
                    if (dico2["cover"] == nil){
                        //portada.text = "no hay portada"
                        libro.portada = image
                        
                    }
                    else{
                        let dico3 = dico2["cover"] as! NSDictionary
                        let img_urls = dico3["medium"] as! String
                        let img_url = NSURL(string: img_urls)
                        let img_datos = NSData(contentsOfURL: img_url!)
                        libro.portada = UIImage(data: img_datos!)
                        
                        
                        
                        
                        
                    }
                    // digo que dico3 es un array por los corchetes que nos muestra en el json
                    
                    
                    let dico3 = dico2["authors"] as! NSArray
                    
                    
                    
                    
                    // recorremos el arreglo buscando la posiciion de "name " que corresponde al nombre
                    for (var i = 0; i < dico3.count; i++ ){
                        let autores = dico3[i] as! NSDictionary
                        //print(autores["name"])
                        libro.autor = autores["name"] as! NSString as String
                        
                        //print(dico3[i])
                        
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
        
        return libro
    }
    
    func nuevoLibro (nuevo : Libro) {
        libros.append(nuevo)
        
        // recargamos el tableview
        self.tableView.reloadData()
        
    }

}
