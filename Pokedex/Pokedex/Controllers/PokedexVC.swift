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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.9321283102, green: 0, blue: 0.5649608374, alpha: 1)
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 88, left: 30, bottom: 0, right: 30))
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
        return CGSize(width: 80, height: 100)
    }
    /*func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let pokemon = pokemons[indexPath.item]
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return PokedexVC(coder: pokemon)
        }, actionProvider: { _ in
            let okItem = UIAction(title: "Pokemon", image: UIImage(systemName: "arrow.down.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        })
    }*/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
}
