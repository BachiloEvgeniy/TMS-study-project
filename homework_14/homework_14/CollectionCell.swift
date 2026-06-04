//
//  CollectionCell.swift
//  homework_14
//
//  Created by Evgeniy Bachilo on 04.06.2026.
//

import UIKit
import SnapKit


class CollectionCell: UICollectionViewCell {
    
    static let Identifier: String = "CollectionCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String){
        imageView.image = UIImage(systemName: name)
        imageView.tintColor = .darkGray 
    }
    
}

private extension CollectionCell {
       func setupUi() {
           contentView.addSubview(imageView)
           
           imageView.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }
       
    }
}
