//
//  HomeTableViewCell.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func buttonTintColorChancer(_ indexPath: IndexPath, button: UIButton)
}

final class HomeTableViewCell: UITableViewCell {
    private let viewModel = HomeViewModel()
    public weak var delegate: HomeTableViewCellDelegate?
    var indexPath: IndexPath!
    
    public let countryTitleLabel: UILabel = {
        let countryTitle = UILabel()
        countryTitle.font = UIFont.boldSystemFont(ofSize: 14)
        countryTitle.numberOfLines = 0
        countryTitle.layer.cornerRadius = 16
        countryTitle.layer.masksToBounds = true
        countryTitle.layer.borderWidth = 2
        countryTitle.layer.borderColor = UIColor.black.cgColor
        return countryTitle
    }()
    
    public var starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        starButton.imageView?.contentMode = .scaleAspectFit
        starButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        return starButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(countryTitleLabel)
        contentView.addSubview(starButton)
        starButton.addTarget(self, action: #selector(starButtonAction(sender:)), for: .touchUpInside)
        setCountryTitleLabelConstraints()
        setStarButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryTitleLabel.text = nil
    }
    
    @objc
    func starButtonAction(sender: UIButton) {
        delegate?.buttonTintColorChancer(indexPath, button: starButton)
        NotificationCenter.default.post(name: Constants.savedNotification, object: nil)
    }
    
    public func setupCountryList(country: CountriesData) {
        countryTitleLabel.text = "   " + "\(country.name)"
    }
    
    private func setCountryTitleLabelConstraints() {
        countryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        countryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        countryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        countryTitleLabel.heightAnchor.constraint(equalToConstant: 52).isActive = true
        countryTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countryTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setStarButtonConstraints() {
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        starButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

