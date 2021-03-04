//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController {
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: PokedexCell.reuseIdentifier)
        
        return collectionView
    }()
    
    private let button: UIButton = {
        let grid = UIButton()
        grid.setTitle("Grid", for: .normal)
        grid.setTitleColor(.blue, for: .normal)
        grid.backgroundImage(for: .normal)
        grid.translatesAutoresizingMaskIntoConstraints = false
        
        return grid
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        view.addSubview(collectionView)
        view.addSubview(button)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
    }
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
                            section: Int) -> Int {
        return pokemons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                            indexPath: IndexPath) -> UICollectionViewCell {
        let poke = pokemons[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCell.reuseIdentifier,
                                                      for: indexPath) as! PokedexCell
        cell.pokemonk = poke
        return cell
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt IndexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
        //grid shit here
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        let vc = PokemonVC(pokemon: pokemon)
        self.navigationController?.pushViewController(vc, animated: true)
        print(pokemon.types)
        print("Selected \(pokemon.name)")
    }
}
