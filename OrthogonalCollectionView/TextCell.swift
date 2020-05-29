/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Generic text cell
*/

import UIKit

class TextCell: UICollectionViewCell {
    
    let productTittle = UILabel()
    let productSubTittle = UILabel()
    let productImage = UIImageView()
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

}

extension TextCell {
    func configure() {
        
    let spacing = CGFloat(10)

    productImage.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(productImage)
        productImage.backgroundColor = .brown
    productTittle.translatesAutoresizingMaskIntoConstraints = false
    productTittle.text = "Trending Now"
    productTittle.textColor = .black
    productTittle.textAlignment = .center
    productTittle.font = UIFont(name: "Avenir-Medium", size: 17)
    productTittle.adjustsFontForContentSizeCategory = true
    contentView.addSubview(productTittle)
    productSubTittle.translatesAutoresizingMaskIntoConstraints = false
    productSubTittle.text = "New Age Collection"
    productSubTittle.textColor = .black
    productSubTittle.textAlignment = .center
    productSubTittle.font = UIFont(name: "Avenir", size: 15)
    productSubTittle.adjustsFontForContentSizeCategory = true
    contentView.addSubview(productSubTittle)
    
    let inset: CGFloat = 0.0
  
    NSLayoutConstraint.activate([
       productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
       productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
       productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
       productTittle.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: spacing),
       productTittle.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
       productTittle.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
       productSubTittle.topAnchor.constraint(equalTo: productTittle.bottomAnchor, constant: spacing),
       productSubTittle.leadingAnchor.constraint(equalTo: productTittle.leadingAnchor),
       productSubTittle.trailingAnchor.constraint(equalTo: productTittle.trailingAnchor)

    ])

        
       
    }
}
