//
//  ViewController.swift
//  22.API
//
//  Created by Sesili Tsikaridze on 10.11.23.
//

import UIKit

class HomeView: UIView {
    
    //MARK: - Properties
    
    var viewModel: HomeViewModel
    
    private let headerView = {
        let headerView = UIView()
        headerView.backgroundColor = .header
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private let headerLogoImage = {
        let headerLogo = UIImageView()
        headerLogo.image = .productLogo
        headerLogo.translatesAutoresizingMaskIntoConstraints = false
        return headerLogo
    }()
    
    private let profileButton = {
        let profileButton = UIButton()
        profileButton.layer.cornerRadius = 8
        profileButton.setTitle("Profile", for: .normal)
        profileButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        profileButton.titleLabel?.textColor = .white
        profileButton.backgroundColor = .primaryOrange
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        return profileButton
    }()
    
    private let nowInLabel = {
        let nowInLabel = UILabel()
        nowInLabel.text = "Now in cinemas"
        nowInLabel.font = .systemFont(ofSize: 24, weight: .black)
        nowInLabel.textColor = .white
        return nowInLabel
    }()
    
    var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 16
        return collectionView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private Methods
    
    func setupUI() {
        backgroundColor = .backgroundBlue
        addSubViews()
        setupConstraints()
        setupCollectionView()
        registerCollectionViewCell()
        observeMoviesFetchingState()
    }
    
    func observeMoviesFetchingState() {
        viewModel.onFetchMovies = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func addSubViews() {
        headerView.addSubview(headerLogoImage)
        headerView.addSubview(profileButton)
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(nowInLabel)
        mainStackView.addArrangedSubview(collectionView)
        addSubview(headerView)
        
    }
    
    private func setupConstraints() {
        headerConstraints()
        headerLogoConstraint()
        headerButtonConstraint()
        stackViewConstraints()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundBlue
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: - Constraints
    
    private func headerConstraints() {
        NSLayoutConstraint.activate ([
            headerView.heightAnchor.constraint(equalToConstant: 108),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func headerLogoConstraint() {
        NSLayoutConstraint.activate ([
            headerLogoImage.heightAnchor.constraint(equalToConstant: 48),
            headerLogoImage.widthAnchor.constraint(equalToConstant: 48),
            headerLogoImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLogoImage.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    private func headerButtonConstraint() {
        NSLayoutConstraint.activate ([
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            profileButton.widthAnchor.constraint(equalToConstant: 77),
            profileButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            profileButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12)
        ])
    }
    
    private func stackViewConstraints() {
        NSLayoutConstraint.activate ([
            mainStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
}

final class HomeViewController: UIViewController {
    var itemView: HomeView
    var viewModel: HomeViewModel
    
    
    init() {
        
        let movieData = Movie(
            originalTitle: "Example Title",
            overview: "Example Overview",
            posterPath: "Example Poster Path",
            releaseDate: "Example Release Date",
            title: "Example Title",
            voteAverage: 5.0
        )
        
        viewModel = HomeViewModel(itemModel: movieData)
        itemView = HomeView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = itemView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovies()
        itemView.observeMoviesFetchingState()
    }
}

//MARK: - Extensions

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let currentFilm = viewModel.movies[indexPath.row]
        cell.configure(with: currentFilm)
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - spacing) / 2
        return CGSize(width: itemWidth, height: 297)
    }
}

