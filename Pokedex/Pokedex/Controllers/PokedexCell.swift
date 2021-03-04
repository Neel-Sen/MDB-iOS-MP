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
            if let url = URL(string: pokemonk!.imageUrl) {
                if let data = try? Data(contentsOf: url) {
                    imageView.image = UIImage(data: data)
                }
            }
            idView.text = pokemonk!.name //should I put this inside the nested if-lets?
            titleView.text = String(pokemonk!.id)
        }
    }
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private let idView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        contentView.addSubview(idView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            idView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -10),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.bottomAnchor.constraint(equalTo: idView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60)

            
            //fix this pls
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
