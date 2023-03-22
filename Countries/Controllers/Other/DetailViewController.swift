//
//  DetailPageViewController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit
import Kingfisher
import SVGKit

class DetailViewController: UIViewController {
    
    public var code: String = String()
    public var wikiID: String = String()
    private let viewModel = DetailViewModel()
    
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
    
    public let navigateButton: UIButton = {
        let navigateButton = UIButton()
        navigateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        navigateButton.setTitle("For More Information →", for: .normal)
        return navigateButton
    }()
    
    public let buttonBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.systemBlue
        return backView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(flagImageView, countryCodeLabel, buttonBackView, navigateButton)
        navigateButton.addTarget(self, action: #selector(moreInfoAction(sender:)), for: .touchUpInside)
        viewModel.delegate = self
        setViewConstraints()
        viewModel.loadCountryDetailData(code: code)
        setNavigationItem()
        
        
    }
    
    @objc
    func settingsTapped() {
        print("hello")
        
    }
    
    @objc
    func moreInfoAction(sender: UIButton) {
        guard let url = URL(string: "https://www.wikidata.org/wiki/" + "\(wikiID)") else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    private func setNavigationItem()  {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(settingsTapped))
        
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
        
        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        navigateButton.centerXAnchor.constraint(equalTo: buttonBackView.centerXAnchor).isActive = true
        navigateButton.centerYAnchor.constraint(equalTo: buttonBackView.centerYAnchor).isActive = true

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
