//
//  MovieDetailViewController.swift
//  22.API
//
//  Created by Sesili Tsikaridze on 10.11.23.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var selectedItem: ResultStruct?
    
    private let headerView = {
        let headerView = UIView()
        headerView.backgroundColor = .header
        headerView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        return headerView
    }()
    
    private let filmNameLabel = {
        let filmNameLabel = UILabel()
        filmNameLabel.font = .systemFont(ofSize: 18, weight: .black)
        filmNameLabel.textColor = .white
        filmNameLabel.numberOfLines = 0
        filmNameLabel.lineBreakMode = .byWordWrapping
        filmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return filmNameLabel
    }()
    
    private let filmPoster = {
        let filmPoster = UIImageView()
        filmPoster.heightAnchor.constraint(equalToConstant: 230).isActive = true
        filmPoster.clipsToBounds = true
        filmPoster.contentMode = .scaleAspectFill
        return filmPoster
    }()
    
    private let ratingView = {
        let ratingView = UIView()
        ratingView.backgroundColor = .header
        ratingView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return ratingView
    }()
    
    private let ratingLabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .systemFont(ofSize: 20, weight: .black)
        ratingLabel.textColor = .white
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    private let descriptionLabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()
    
    private let certificateLabel = {
        let certificateLabel = UILabel()
        certificateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        certificateLabel.textColor = .lightGray
        return certificateLabel
    }()
    
    private let runTimeLabel = {
        let runTimeLabel = UILabel()
        runTimeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        runTimeLabel.textColor = .lightGray
        return runTimeLabel
    }()
    
    private let releaseLabel = {
        let releaseLabel = UILabel()
        releaseLabel.font = .systemFont(ofSize: 14, weight: .regular)
        releaseLabel.textColor = .lightGray
        return releaseLabel
    }()
    
    private let genreLabel = {
        let genreLabel = UILabel()
        genreLabel.font = .systemFont(ofSize: 14, weight: .regular)
        genreLabel.textColor = .lightGray
        return genreLabel
    }()
    
    private let directorLabel = {
        let directorLabel = UILabel()
        directorLabel.font = .systemFont(ofSize: 14, weight: .regular)
        directorLabel.textColor = .lightGray
        return directorLabel
    }()
    
    private let castLabel = {
        let castLabel = UILabel()
        castLabel.font = .systemFont(ofSize: 14, weight: .regular)
        castLabel.textColor = .lightGray
        return castLabel
    }()
    
    private let certificateValueLabel = {
        let certificateValueLabel = UILabel()
        certificateValueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        certificateValueLabel.textColor = .white
        return certificateValueLabel
    }()
    
    private let runtimeValueLabel = {
        let runtimeValueLabel = UILabel()
        runtimeValueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        runtimeValueLabel.textColor = .white
        return runtimeValueLabel
    }()
    
    private let releaseValueLabel = {
        let releaseValueLabel = UILabel()
        releaseValueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        releaseValueLabel.textColor = .white
        return releaseValueLabel
    }()
    
    private let genreValueLabel = {
        let genreValueLabel = UILabel()
        genreValueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        genreValueLabel.textColor = .white
        return genreValueLabel
    }()
    
    private let directorValueLabel = {
        let directorValueLabel = UILabel()
        directorValueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        directorValueLabel.textColor = .white
        return directorValueLabel
    }()
    
    private let castValueLabel = {
        let castValueLabel = UILabel()
        castValueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        castValueLabel.textColor = .white
        castValueLabel.numberOfLines = 0
        castValueLabel.lineBreakMode = .byWordWrapping
        return castValueLabel
    }()
    
    private let bottomView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .header
        bottomView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    private let selectSessionButton = {
        let selectSessionButton = UIButton()
        selectSessionButton.backgroundColor = .primaryOrange
        selectSessionButton.layer.cornerRadius = 8
        selectSessionButton.setTitle("Select Session", for: .normal)
        selectSessionButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        selectSessionButton.titleLabel?.textColor = .white
        selectSessionButton.translatesAutoresizingMaskIntoConstraints = false
        return selectSessionButton
    }()
    
    private let certificateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 12
        return stackView
    }()
    
    private let valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 12
        return stackView
    }()
    
    private let valuesHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    private let wholeTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlue
        addViews()
        setupUI()
        setupConstraints()
    }
    
    
    //MARK: - Functions
    
    private func addViews() {
        view.addSubview(mainStackView)
        ratingView.addSubview(ratingLabel)
        headerView.addSubview(filmNameLabel)
        mainStackView.addArrangedSubview(headerView)
        mainStackView.addArrangedSubview(filmPoster)
        mainStackView.addArrangedSubview(ratingView)
        
        certificateStackView.addArrangedSubview(certificateLabel)
        certificateStackView.addArrangedSubview(runTimeLabel)
        certificateStackView.addArrangedSubview(releaseLabel)
        certificateStackView.addArrangedSubview(genreLabel)
        certificateStackView.addArrangedSubview(directorLabel)
        certificateStackView.addArrangedSubview(castLabel)
        
        valuesStackView.addArrangedSubview(certificateValueLabel)
        valuesStackView.addArrangedSubview(runtimeValueLabel)
        valuesStackView.addArrangedSubview(releaseValueLabel)
        valuesStackView.addArrangedSubview(genreValueLabel)
        valuesStackView.addArrangedSubview(directorValueLabel)
        valuesStackView.addArrangedSubview(castValueLabel)
        
        valuesHorizontalStackView.addArrangedSubview(certificateStackView)
        valuesHorizontalStackView.addArrangedSubview(valuesStackView)
        
        mainStackView.addArrangedSubview(wholeTextStackView)
        wholeTextStackView.addArrangedSubview(descriptionLabel)
        wholeTextStackView.addArrangedSubview(valuesHorizontalStackView)
        
        view.addSubview(bottomView)
        bottomView.addSubview(selectSessionButton)
        
        
    }
    
    private func setupConstraints() {
        stackViewConstraints()
        filmNameConstraints()
        ratingLabelConstraints()
        bottomViewConstraints()
        buttonConstraints()
    }
    
    
    private func setupUI() {
        let urlString = "https://image.tmdb.org/t/p/original/\(selectedItem?.backdropPath ?? "https://image.tmdb.org/t/p/original/NNxYkU70HPurnNCSiCjYAmacwm.jpg")"
        filmPoster.loadFrom(stringUrl: urlString)
        filmNameLabel.text = selectedItem?.originalTitle
        ratingLabel.text = "\(selectedItem?.voteAverage ?? 0)"
        
        descriptionLabel.text = selectedItem?.overview
        certificateLabel.text = "Certificate"
        runTimeLabel.text = "Runtime"
        releaseLabel.text = "Release"
        genreLabel.text = "Rating"
        directorLabel.text = "Director"
        castLabel.text = "Cast"
        
        certificateValueLabel.text = "16+"
        runtimeValueLabel.text = "02:56"
        releaseValueLabel.text = selectedItem?.releaseDate
        genreValueLabel.text = "\(selectedItem?.voteAverage ?? 0)"
        directorValueLabel.text = "Matt Reeves"
        castValueLabel.text = "Robert Pattinson, Zoë Kravitz, Jeffrey Wright, Colin Farrell, Paul Dano, John Turturro, Andy Serkis, Peter Sarsgaard"
    }
    
    
    private func stackViewConstraints() {
        NSLayoutConstraint.activate ([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -50)
        ])
    }
    
    private func filmNameConstraints() {
        NSLayoutConstraint.activate([
            filmNameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            filmNameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -23)
        ])
    }
    
    private func ratingLabelConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor)
        ])
    }
    
    private func bottomViewConstraints() {
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func buttonConstraints() {
        NSLayoutConstraint.activate([
            selectSessionButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            selectSessionButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            selectSessionButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16),
            selectSessionButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16)
        ])
    }
}
