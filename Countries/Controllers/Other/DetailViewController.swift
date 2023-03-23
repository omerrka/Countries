//
//  DetailViewController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    public var code: String = String()
    private let viewModel = DetailViewModel()
    var indexPath: IndexPath!
    var countries: [CountriesData]?
    
    private let flagImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    public let moreInfoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        infoButton.setTitle("For More Information →", for: .normal)
        return infoButton
    }()
    
    public let buttonBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.systemBlue
        return backView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        view.addSubviews(flagImageView, countryCodeLabel, buttonBackView, moreInfoButton)
        moreInfoButton.addTarget(self, action: #selector(moreInfoAction(sender:)), for: .touchUpInside)
        tabBarController?.tabBar.isHidden = true
        viewModel.delegate = self
        setViewConstraints()
        viewModel.loadCountryDetailData(code: code)
        setNavigationItem()
    }
    
    public func configureCountries(countries: [CountriesData]) {
        self.countries = countries
    }
    
    @objc
    func starButtonTapped() {
        if !SavedCountires.shared.savedCountries.contains(where: { $0.name == countries![indexPath.row].name }) {
            SavedCountires.shared.savedCountries.append(countries![indexPath.row])
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(starButtonTapped))
        } else {
            if let Index = SavedCountires.shared.savedCountries.firstIndex(where: { $0.name == countries![indexPath.row].name }) {
                SavedCountires.shared.savedCountries.remove(at: Index)
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starButtonTapped))
            }
        }
        
        NotificationCenter.default.post(name: Constants.savedNotification, object: nil)
        NotificationCenter.default.post(name: Constants.homeNotification, object: nil)
    }
    
    @objc
    func moreInfoAction(sender: UIButton) {
        guard let url = URL(string: "https://www.wikidata.org/wiki/" + "\(viewModel.countryDetail?.wikiDataID ?? "")") else {return}
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    private func setNavigationItem()  {
        if !SavedCountires.shared.savedCountries.contains(where: { $0.code == self.code }) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(starButtonTapped))
        }
    }
    
    private func setViewConstraints() {
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        flagImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.size.height)*(4.5/10)).isActive = true
        
        countryCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCodeLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 18).isActive = true
        countryCodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        countryCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        
        buttonBackView.translatesAutoresizingMaskIntoConstraints = false
        buttonBackView.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor, constant: 18).isActive = true
        buttonBackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        buttonBackView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        moreInfoButton.centerXAnchor.constraint(equalTo: buttonBackView.centerXAnchor).isActive = true
        moreInfoButton.centerYAnchor.constraint(equalTo: buttonBackView.centerYAnchor).isActive = true
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func configureDetailView() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.viewModel.countryDetail?.name
            self.countryCodeLabel.text = "Country Code:" + " \(self.viewModel.countryDetail?.code ?? "")"
            self.countryCodeLabel.halfTextFontChange(fullText: self.countryCodeLabel.text!, changeText: "Country Code:")
            self.flagImageView.kf.setImage(with: URL(string: "\(self.viewModel.countryDetail?.flagImageURI ?? "")"), options: [.processor(SVGImgProcessor())])
        }
    }
}
