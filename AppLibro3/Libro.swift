//
//  Libro.swift
//  AppLibro3
//
//  Created by Arturo Barreto Villafán on 12/16/15.
//  Copyright © 2015 Arturo Barreto Villafán. All rights reserved.
//

import UIKit

class Libro: NSObject {
    
    var isbn : String?
    var titulo: String?
    var autor: String?
    var portada: UIImage?
    
    init(isbn : String) {
        self.isbn = isbn
    }

}
