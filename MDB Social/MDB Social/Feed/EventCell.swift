//
//  EventCell.swift
//  MDB Social
//
//  Created by Neel Ayon Sen on 17/3/21.
//

import UIKit

class EventCell: UIViewController {

    static let reuseIdentifier: String = String(describing: EventCell.self)
    
    var event: Event? {
        didSet {
            
            idView.text = event!.name //should I put this inside the nested if-lets?
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
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        addSubview(imageView)
        addSubview(titleView)
        addSubview(idView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            idView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -1 * frame.height / 275),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1 * (frame.height / 140)),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.bottomAnchor.constraint(equalTo: idView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: frame.height / 2)

            
        ])
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
