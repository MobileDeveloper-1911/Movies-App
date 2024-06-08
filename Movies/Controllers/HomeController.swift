//
//  HomeController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 22/05/24.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var nowPlayingCollectionView : UICollectionView!
    @IBOutlet weak var bannerCollectionView : UICollectionView!
    @IBOutlet weak var topRatedCollectionView : UICollectionView!
    @IBOutlet weak var upcomingCollectionView : UICollectionView!
    
    private var popularMoviesVM = MoviesViewModel()
    var moviesDataPopular : CommonMovieModel?
    var moviesDataNowPlaying : CommonMovieModel?
    var moviesDataTopRated : CommonMovieModel?
    var moviesDataUpcoming : CommonMovieModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nowPlayingCollectionView?.register(MoviesCollectionCell.nib(), forCellWithReuseIdentifier: MoviesCollectionCell.reusableIdentifier)
        
        bannerCollectionView.register(BannerViewCell.nib(), forCellWithReuseIdentifier: BannerViewCell.reusableIdentifier)
        
        topRatedCollectionView.register(MoviesCollectionCell.nib(), forCellWithReuseIdentifier: MoviesCollectionCell.reusableIdentifier)
        
        upcomingCollectionView.register(MoviesCollectionCell.nib(), forCellWithReuseIdentifier: MoviesCollectionCell.reusableIdentifier)
        
        

        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        

        
        
        observeEvents(movieTye:  .popular)
        observeEvents(movieTye: .nowPlaying)
        observeEvents(movieTye: .topRated)
        observeEvents(movieTye: .upcoming)

    }
    
    
    func observeEvents(movieTye: MovieType){
        self.popularMoviesVM.fetchPopularMovies(movieType: movieTye)
        self.popularMoviesVM.events = { [weak self] event, type, responseData in
             
            
            guard let self = self else { return }
            switch event {
            case .loading:
                break
                
            case .success:
                
                switch type {
                    
                case .popular:
                    self.moviesDataPopular = responseData
                case .nowPlaying:
                    self.moviesDataNowPlaying = responseData
                case .topRated:
                    self.moviesDataTopRated = responseData
                    break
                case .upcoming:
                    self.moviesDataUpcoming = responseData
                    break
                }
                
    
                DispatchQueue.main.async {
                    print("")
                    self.nowPlayingCollectionView?.reloadData()
                    self.bannerCollectionView.reloadData()
                    self.topRatedCollectionView.reloadData()
                    self.upcomingCollectionView.reloadData()
                }
                break
                
             
            case .stopLoading:
                break
                
            case .error(error: let error):
                print(error)

                break
            }
        }
    }
    
}

extension HomeController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == nowPlayingCollectionView {
            return moviesDataNowPlaying?.results?.count ?? 0
        }else if collectionView == topRatedCollectionView {
            return moviesDataTopRated?.results?.count ?? 0
        }else if collectionView == upcomingCollectionView {
            return moviesDataUpcoming?.results?.count ?? 0
        }else{
            return moviesDataPopular?.results?.count ?? 0

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == nowPlayingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.reusableIdentifier, for: indexPath) as! MoviesCollectionCell
            
            cell.moviesImage.setImage(with: moviesDataNowPlaying?.results?[indexPath.row].poster_path ?? "")
            cell.parentView.clipsToBounds = true
            cell.parentView.layer.cornerRadius = 16
            
            return cell
        }else if(collectionView == topRatedCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.reusableIdentifier, for: indexPath) as! MoviesCollectionCell
            
            cell.moviesImage.setImage(with: moviesDataTopRated?.results?[indexPath.row].poster_path ?? "")
            cell.parentView.clipsToBounds = true
            cell.parentView.layer.cornerRadius = 16
            
            return cell
            
        }else if(collectionView == upcomingCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.reusableIdentifier, for: indexPath) as! MoviesCollectionCell
            
            cell.moviesImage.setImage(with: moviesDataUpcoming?.results?[indexPath.row].poster_path ?? "")
            cell.parentView.clipsToBounds = true
            cell.parentView.layer.cornerRadius = 16
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.reusableIdentifier, for: indexPath) as! BannerViewCell
            
            cell.bannerImage.setImage(with: moviesDataPopular?.results?[indexPath.row].backdrop_path ?? "")
            cell.parentView.clipsToBounds = true
            cell.parentView.layer.cornerRadius = 16
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == nowPlayingCollectionView ||  collectionView == topRatedCollectionView || collectionView == upcomingCollectionView  {
            return CGSize(width: (collectionView.frame.width - 30) / 3, height: 200)

        }
        else{
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.frame.height)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     
        
        if collectionView == self.bannerCollectionView {
        
            goToDetailsScreen(responseData: moviesDataPopular!,indexPath: indexPath.row)
        
            
        }else if collectionView == self.nowPlayingCollectionView {
            
            goToDetailsScreen(responseData: moviesDataNowPlaying!,indexPath: indexPath.row)
           
            
        }else if collectionView == self.topRatedCollectionView {
            
            goToDetailsScreen(responseData: moviesDataTopRated!,indexPath: indexPath.row)

            
        }else if collectionView == self.upcomingCollectionView {
            
            goToDetailsScreen(responseData: moviesDataUpcoming!,indexPath: indexPath.row)
          
            
        }
    }
    
    func goToDetailsScreen(responseData : CommonMovieModel, indexPath : Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailController") as! MovieDetailController
        newVC.posterImageURL = responseData.results?[indexPath].backdrop_path
        newVC.movieImageURL = responseData.results?[indexPath].poster_path
        newVC.titleText = responseData.results?[indexPath].original_title
        newVC.languageText = responseData.results?[indexPath].original_language
        newVC.releaseDateText = responseData.results?[indexPath].release_date
        newVC.overViewText = responseData.results?[indexPath].overview
        newVC.movieID = responseData.results?[indexPath].id
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newVC, animated: true)
    }
 
    
    
    
    
}
