//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Neel Ayon Sen on 2/3/21.
//

import UIKit

class PokedexCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: PokedexCell.self)
    
    var pokemonk: Pokemon? {
        didSet {
            let url = URL(string: (pokemonk?.imageUrl)!)
            let data = try? Data(contentsOf: url!)
            imageView.image = UIImage(data: data!)
            titleView.text = pokemonk?.name
            
            
        }
    }
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .red
        iv.contentMode = .scaleAspectFit
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .blue
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9321283102, green: 0, blue: 0.5649608374, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.9321283102, green: 0, blue: 0.5649608374, alpha: 1)
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}