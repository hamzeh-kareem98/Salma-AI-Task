//
//  CountryCell.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/11/24.
//

import UIKit

class CountryCell: UITableViewCell {
    private var flageImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        return view
    }()
    
    private var horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    
    
    func configure(with model: CountryModel) {
        selectionStyle = .none
        
        if let url = URL(string: model.flags.png) {
            downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    self.flageImageView.image = image
                    self.setupViews(model: model)
                    self.setupConstraints()
                }
            }
        }
    
        
    }
    
    private func setupViews(model: CountryModel) {
        contentView.addSubview(horizontalStackView)
        
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        stackView.addArrangedSubview(GenerateLabel(text: "Name : \(model.name.common)"))
        stackView.addArrangedSubview(GenerateLabel(text: "Currency : \(model.currencies?.first?.value.name ?? "")"))
        stackView.addArrangedSubview(GenerateLabel(text: "Currency Code : \(model.currencies?.first?.key ?? "")"))
        
        imageContentView.addSubview(flageImageView)
        
        horizontalStackView.addArrangedSubview(imageContentView)
        horizontalStackView.addArrangedSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        
        NSLayoutConstraint.activate([
            flageImageView.leadingAnchor.constraint(equalTo: imageContentView.leadingAnchor, constant: 10),
            flageImageView.topAnchor.constraint(equalTo: imageContentView.topAnchor, constant: 12),
            flageImageView.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -22),
            flageImageView.trailingAnchor.constraint(equalTo: imageContentView.trailingAnchor, constant: -8)
            
        ])

        NSLayoutConstraint.activate([
            imageContentView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3)
            
        ])
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        
        task.resume()
    }
    
    private func GenerateLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.text = text
        return label
    }
}
