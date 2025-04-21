//
//  TableViewCell.swift
//  poketmonPhoneBook
//
//  Created by 김기태 on 4/21/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let id = "TableViewCell"
    
    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    private let numLabel: UILabel = {
        let label = UILabel()
        label.text = "000-0000-0000"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [
            pokemonImageView,
            nameLabel,
            numLabel
        ]
            .forEach { contentView.addSubview($0) }
        
        pokemonImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.size.equalTo(60)
            
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(pokemonImageView.snp.centerY)
            $0.leading.equalTo(pokemonImageView.snp.trailing).offset(40)
        }
        numLabel.snp.makeConstraints {
            $0.centerY.equalTo(pokemonImageView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}
