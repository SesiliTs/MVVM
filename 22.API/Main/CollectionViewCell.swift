import Foundation
import UIKit


final class CustomCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var filmPoster = {
        let filmPoster = UIImageView()
        filmPoster.contentMode = .scaleAspectFill
        filmPoster.translatesAutoresizingMaskIntoConstraints = false
        filmPoster.clipsToBounds = true
        filmPoster.heightAnchor.constraint(equalToConstant: 230).isActive = true
        return filmPoster
    }()
    
    private var filmNameLabel = {
        let filmNameLabel = UILabel()
        filmNameLabel.font = .systemFont(ofSize: 16, weight: .black)
        filmNameLabel.textColor = .white
        filmNameLabel.numberOfLines = 0
        filmNameLabel.lineBreakMode = .byWordWrapping
        return filmNameLabel
    }()
    
    private var filmCategoryLabel = {
        let filmCategoryLabel = UILabel()
        filmCategoryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        filmCategoryLabel.textColor = .lightGray
        return filmCategoryLabel
    }()
    
    private let ratingView = {
        let ratingView = UIView()
        ratingView.backgroundColor = .primaryOrange
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.layer.cornerRadius = 4
        return ratingView
    }()
    
    private var ratingLabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .systemFont(ofSize: 12, weight: .bold)
        ratingLabel.textColor = .white
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    private var heartImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = .heart
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    private var heartButton = {
        let heartButton = UIButton()
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        return heartButton
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        return stackView
    }()
    
    
    //MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
        prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func addViews() {
        contentView.addSubview(filmPoster)
        contentView.addSubview(filmNameLabel)
        labelStackView.addArrangedSubview(filmNameLabel)
        labelStackView.addArrangedSubview(filmCategoryLabel)
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(filmPoster)
        mainStackView.addArrangedSubview(labelStackView)
        contentView.addSubview(ratingView)
        ratingView.addSubview(ratingLabel)
        contentView.addSubview(heartImageView)
        contentView.addSubview(heartButton)
        
    }
    
    private func setupConstraints() {
        stackViewConstraints()
        ratingViewConstraints()
        ratingLabelConstraints()
        heartImageViewConstraints()
        heartButtonConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filmPoster.image = nil
        filmNameLabel.text = nil
    }
    
    private func ratingViewConstraints() {
        NSLayoutConstraint.activate([
            ratingView.heightAnchor.constraint(equalToConstant: 23),
            ratingView.widthAnchor.constraint(equalToConstant: 33),
            ratingView.trailingAnchor.constraint(equalTo: filmPoster.trailingAnchor, constant: -4),
            ratingView.topAnchor.constraint(equalTo: filmPoster.topAnchor, constant: 4)
        ])
    }
    
    private func ratingLabelConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor)
        ])
    }
    
    private func heartImageViewConstraints() {
        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(equalToConstant: 20),
            heartImageView.widthAnchor.constraint(equalToConstant: 20),
            heartImageView.leadingAnchor.constraint(equalTo: filmPoster.leadingAnchor, constant: 4),
            heartImageView.topAnchor.constraint(equalTo: filmPoster.topAnchor, constant: 4)
        ])
    }
    
    private func heartButtonConstraints() {
        NSLayoutConstraint.activate([
            heartButton.heightAnchor.constraint(equalToConstant: 20),
            heartButton.widthAnchor.constraint(equalToConstant: 20),
            heartButton.leadingAnchor.constraint(equalTo: filmPoster.leadingAnchor, constant: 4),
            heartButton.topAnchor.constraint(equalTo: filmPoster.topAnchor, constant: 4)
        ])
        heartButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func stackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func likeButtonTapped() {
        if heartImageView.image == .heart {
            heartImageView.image = . heartFilled
        } else {
            heartImageView.image = .heart
        }
    }
    
    func configure(with model: ResultStruct) {
        let urlString = "https://image.tmdb.org/t/p/original/\(model.backdropPath)"
        
        let rating = model.voteAverage
        let roundedRating = Double(round(rating * 10) / 10)
        
        filmPoster.loadFrom(stringUrl: urlString)
        filmNameLabel.text = model.originalTitle
        ratingLabel.text = "\(roundedRating)"
    }
    
}

extension UIImageView {
    func loadFrom(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
}
