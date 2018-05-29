//
//  Categoria.swift
//  DrawingApp
//
//  Created by Gustavo Rodrigues on 29/05/18.
//  Copyright © 2018 Gustavo Rodrigues. All rights reserved.
//

import Foundation

class Categoria{
    
    //var nome: String
    var palavras = [String]()
    
    init(categoria: String){
        
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: categoria) else { return }
        
        if let palavras = dictionary["palavras"] as? [String]{
            self.palavras = palavras
        }
    }
    
    func sortear() -> String{
        let randomIndex = Int(arc4random_uniform(UInt32(palavras.count)))
        return palavras[randomIndex]
    }
}
