//
//  ViewController.swift
//  22.API
//
//  Created by Sesili Tsikaridze on 10.11.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
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
    
    private var collectionView = {
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
    
    private var films = [ResultStruct]()
    private let url = "https://api.themoviedb.org/3/movie/popular?api_key=0121a87cc86615dcfff388722ec6de80"
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlue
        addSubViews()
        setupConstraints()
        setupCollectionView()
        
        NetworkService.shared.getData(urlString: url) { (result: Result<Film, Error>) in
            switch result {
            case .success(let data):
                self.films = data.results
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Private Methods
    
    private func addSubViews() {
        headerView.addSubview(headerLogoImage)
        headerView.addSubview(profileButton)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(nowInLabel)
        mainStackView.addArrangedSubview(collectionView)
        view.addSubview(headerView)
        
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
        collectionView.backgroundColor = view.backgroundColor
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: - Constraints
    
    private func headerConstraints() {
        NSLayoutConstraint.activate ([
            headerView.heightAnchor.constraint(equalToConstant: 108),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
}

//MARK: - Extensions

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let currentFilm = films[indexPath.row]
        cell.configure(with: currentFilm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = films[indexPath.row]
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.selectedItem = selectedItem
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - spacing) / 2
        return CGSize(width: itemWidth, height: 297)
    }
}

