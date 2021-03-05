//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController {
    var isRow = false
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
        let grid = UIButton(frame: CGRect(x: 1300, y: 400, width: 50, height: 50))
        grid.setTitle("Row", for: .normal)
        grid.setTitleColor(.blue, for: .normal)
        grid.backgroundImage(for: .normal)
        grid.backgroundColor = .red
        grid.tintColor = .black
        grid.translatesAutoresizingMaskIntoConstraints = false
        
        return grid
    }()
    
    @objc func didTapButton(_ sender: UIButton) {
        if isRow == false {
            isRow = true
        } else {
            isRow = false
        }
        return
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        view.addSubview(collectionView)
        view.addSubview(button)
        //button.frame = CGRectMake(800, 700, 100, 100)
        //button.frame = view.bounds.inset(by: UIEdgeInsets(top: 80, left: 400, bottom: 800, right: 200))
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        //view.bringSubviewToFront(button)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            //button.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            //button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            //button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
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
        if isRow == true {
            return CGSize(width: view.bounds.width * 0.6, height: view.bounds.height * 0.2)
        } else {
            return CGSize(width: view.bounds.width * 0.35, height: view.bounds.height * 0.2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        let vc = PokemonVC(pokemon: pokemon)
        self.navigationController?.pushViewController(vc, animated: true)
        print(pokemon.types)
        print("Selected \(pokemon.name)")
    }
}
