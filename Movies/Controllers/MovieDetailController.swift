//
//  MovieDetailControllerViewController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 03/06/24.
//

import UIKit

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var movieImage : UIImageView!
    @IBOutlet weak var playButton : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var releaseDateLabel : UILabel!
    @IBOutlet weak var overviewLabel : UILabel!
    @IBOutlet weak var similarMoviesCollectionView : UICollectionView!
    
    var similarMoviesVM = SimilarMovies()
    var similarMovieResponse : CommonMovieModel?
    
    var posterImageURL: String?
    var movieImageURL: String?
    var titleText: String?
    var languageText: String?
    var releaseDateText: String?
    var overViewText: String?
    var movieID: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.register(MoviesCollectionCell.nib(), forCellWithReuseIdentifier: MoviesCollectionCell.reusableIdentifier)
        
        posterImage.setImage(with: posterImageURL ?? "")
        movieImage.setImage(with: movieImageURL ?? "")
        titleLabel.text = titleText
        
        if let language = languageText {
            languageLabel.text = "Language: \(language)"
        }
        
        if let releaseDate = releaseDateText{
            releaseDateLabel.text = "Release Date: \(releaseDate)"
        }
        overviewLabel.text = overViewText
        
        if let id = movieID {
            observeEvents(movieIDValue: id)
        }
        
        

    }
    
    func observeEvents(movieIDValue: Int) {
        similarMoviesVM.getSimilarMovies(movieID: movieIDValue)
        
        similarMoviesVM.events = {
            [weak self] events in guard let self else{
                return
            }
            
            switch events {
                
            case .loading:
                print("loading")
            case .stopLoading:
                print("stop loading")
            case .success:
                self.similarMovieResponse = self.similarMoviesVM.similarMoviesData
                DispatchQueue.main.async {
                    self.similarMoviesCollectionView.reloadData()
                }
            case .error(error: let error):
                print(error)
            }
        }
        
    }
}

extension MovieDetailController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovieResponse?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.reusableIdentifier, for: indexPath) as! MoviesCollectionCell
        
        cell.parentView.layer.cornerRadius = 16
        cell.moviesImage.setImage(with: similarMovieResponse?.results?[indexPath.row].poster_path ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 30) / 3 , height: collectionView.frame.height)
    }
    
    
}
