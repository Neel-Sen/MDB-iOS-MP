//
//  PokemonVCViewController.swift
//  Pokedex
//
//  Created by Neel Ayon Sen on 3/3/21.
//

import UIKit

class PokemonVC: UIViewController {
    
    //var p: Pokemon
    
    private let cView: UIStackView = { //should it be a stackview??
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 40
        return stack
    }()
    
    var pokemonk: Pokemon? {
        didSet {
            if let url = URL(string: pokemonk!.imageUrl) {
                if let data = try? Data(contentsOf: url) {
                    imageView.image = UIImage(data: data)
                }
            }
            nameLabel.text = pokemonk!.name //should I put this inside the nested if-lets?
            idLabel.text = String(pokemonk!.id)
            healthLabel.text = String(pokemonk!.health)
            typeLabel.text = pokemonk!.types[0].rawValue
            attackLabel.text = String(pokemonk!.attack)
            defenseLabel.text = String(pokemonk!.defense)
            spAttackLabel.text = String(pokemonk!.specialAttack)
            spDefenseLabel.text = String(pokemonk!.specialDefense)
            speedLabel.text = String(pokemonk!.speed)
        }
    }
   private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1

        label.text = "Name: "
        return label
    }()
    
    private let healthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        
        label.numberOfLines = 1
        label.text = "Health: "
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Types: "
        return label
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Attack: "
        return label
    }()
    
    private let defenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Defense: "
        return label
    }()
    
    private let spAttackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Special Attack: "
        return label
    }()
    
    private let spDefenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Special Defense: "
        return label
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Speed: "
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(cView)
        if let url = URL(string: pokemonk!.imageUrl) {
            if let data = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: data)
            }
        }
        cView.addArrangedSubview(imageView)
        nameLabel.text?.append(pokemonk!.name)
        cView.addArrangedSubview(nameLabel)
        idLabel.text?.append(String(pokemonk!.id))
        cView.addArrangedSubview(idLabel)
        healthLabel.text?.append(String(pokemonk!.health))
        cView.addArrangedSubview(healthLabel)
        var count = 0
        while count < pokemonk!.types.endIndex {
            typeLabel.text?.append(pokemonk!.types[count].rawValue)
            if count != pokemonk!.types.endIndex - 1 {
                typeLabel.text?.append(", ")
            }
            count = count + 1
        }

        cView.addArrangedSubview(typeLabel)
        attackLabel.text?.append(String(pokemonk!.attack))
        cView.addArrangedSubview(attackLabel)
        defenseLabel.text?.append(String(pokemonk!.defense))
        cView.addArrangedSubview(defenseLabel)
        spAttackLabel.text?.append(String(pokemonk!.specialAttack))
        cView.addArrangedSubview(spAttackLabel)
        spDefenseLabel.text?.append(String(pokemonk!.specialDefense))
        cView.addArrangedSubview(spDefenseLabel)
        speedLabel.text?.append(String(pokemonk!.speed))
        cView.addArrangedSubview(speedLabel)

        // Do any additional setup after loading the view.
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: cView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: cView.centerYAnchor),
            cView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75)
        ])
    }
    
    init(pokemon: Pokemon){
        self.pokemonk = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
