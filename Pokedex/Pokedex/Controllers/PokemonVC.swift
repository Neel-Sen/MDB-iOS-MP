//
//  PokemonVCViewController.swift
//  Pokedex
//
//  Created by Neel Ayon Sen on 3/3/21.
//

import UIKit

class PokemonVC: UIViewController {
    
    var p: Pokemon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundColor = .black
        
        // Do any additional setup after loading the view.
    }
    
    func init(pokemon: Pokemon){
        self.p = pokemon
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
