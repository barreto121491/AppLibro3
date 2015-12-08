//
//  TablaLibros.swift
//  AppLibro3
//
//  Created by Arturo Barreto Villafán on 12/6/15.
//  Copyright © 2015 Arturo Barreto Villafán. All rights reserved.
//

import UIKit

class TablaLibros: UITableViewController {
    
    

    @IBOutlet weak var clave: UISearchBar!
   
    var Libros : Array<Array<String>> = Array<Array<String>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Busqueda de Libros"
        
        Libros.append(["Don Quijote de La Mancha","9788497364676"])
        Libros.append(["Roxette - Joyride", "0895246732"])
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigati9780440975342on bar for this view controller.
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
        return Libros.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = self.Libros[indexPath.row][0]
        return cell
    }
    
    func buscarLibro(ISBN: String)-> Array<Array<String>>{
        //var Libro : Array<Array<String>> = Array<Array<String>> ()
        
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
                        //print(dico2["title"])
                        
                        let titulo : String = dico2["title"] as! String
                        Libros.append([titulo,ISBN])
                        
                        //titu.text = dico2["title"] as! NSString as String
                        // digo que dico3 es un array por los corchetes que nos muestra en el json
                        
                        
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
            
            
            

        
        return Libros
        
    
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
        
        let cc = segue.destinationViewController as! VistaLibros
        
        let ip = tableView.indexPathForSelectedRow
        
        cc.ISBN = Libros[(ip?.row)!][1]
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    @IBAction func add(sender: AnyObject) {
        
        
        buscarLibro(clave.text!)
        tableView.reloadData()
        clave.text = nil
            }

}
