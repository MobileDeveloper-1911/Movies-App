//
//  ProfileController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 25/05/24.
//

import UIKit

class TvseriessController: UIViewController {
    
    @IBOutlet weak var todaysReleaseCollectionView : UICollectionView!
    @IBOutlet weak var tvSeriesListCollection : UICollectionView!
    @IBOutlet weak var tvSeriesCollectionView : UICollectionView!
    
    let tvSeriesList = ["On Air","Popular","Top Rated"]
    
    var tvSeriesVM = TvSeriesViewModal()
    var seriesType = "airing_today"
    
    var seriesResponseData : CommonMovieModel?
    
    var onAiringSeriesResponseData : CommonMovieModel?
    var onAirSeriesResponseData : CommonMovieModel?
    var popularSeriesResponseData : CommonMovieModel?
    var topRatedSeriesResponseData : CommonMovieModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        todaysReleaseCollectionView.register(BannerViewCell.nib(), forCellWithReuseIdentifier: BannerViewCell.reusableIdentifier)
        
        tvSeriesListCollection.register(SeriesTypeCell.nib(), forCellWithReuseIdentifier: SeriesTypeCell.reusableIdentifier)
        
        tvSeriesCollectionView.register(MoviesCollectionCell.nib(), forCellWithReuseIdentifier: MoviesCollectionCell.reusableIdentifier)
        
        todaysReleaseCollectionView.delegate = self
        todaysReleaseCollectionView.dataSource = self
        tvSeriesListCollection.delegate = self
        tvSeriesListCollection.dataSource = self
        tvSeriesCollectionView.delegate = self
        tvSeriesCollectionView.dataSource = self
       
 
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.observeEvents(seriesType: .airingToday)
        }
        //self.observeEvents(seriesType: .onTheAir)

       
        

    }
    
    func observeEvents(seriesType: SeriesType) {
        self.tvSeriesVM.fetchTvSeries(seriesType: seriesType)
        self.tvSeriesVM.events = { [weak self ] events, seriesTyp, responseData in
            
            
            switch events {
            case .loading :
                
                break
                
            case .success :
                print(seriesType)
                switch seriesType {
                case .airingToday:
                    self?.onAiringSeriesResponseData = responseData

                case .onTheAir:
                    self?.seriesType = seriesType.rawValue
                    self?.seriesResponseData = responseData
                case .popular:
                    self?.seriesType = seriesType.rawValue
                    self?.seriesResponseData = responseData
                case .topRated:
                    self?.seriesType = seriesType.rawValue
                    self?.seriesResponseData = responseData
                }
                
                DispatchQueue.main.async {
                    self?.todaysReleaseCollectionView.reloadData()
                    self?.tvSeriesCollectionView.reloadData()
                    
                }
                break
            
            case .stopLoading :
                break
                
            case .error(error: let error) :
                print(error)
                break
            }
        }
    }


}

extension TvseriessController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == todaysReleaseCollectionView || collectionView == tvSeriesCollectionView {
            if seriesType == "airing_today"{
                return onAiringSeriesResponseData?.results!.count ?? 0
            }else{
                return seriesResponseData?.results?.count ?? 0
            }

        }else{
            return tvSeriesList.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == todaysReleaseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.reusableIdentifier, for: indexPath) as! BannerViewCell
    
            cell.parentView.clipsToBounds = true
            cell.parentView.layer.cornerRadius = 16
            cell.bannerImage.setImage(with: (onAiringSeriesResponseData?.results?[indexPath.row].backdrop_path)!)
            
            return cell
        } else if collectionView == tvSeriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.reusableIdentifier, for: indexPath) as! MoviesCollectionCell
            
            cell.parentView.layer.cornerRadius = 16
            cell.moviesImage.setImage(with: seriesResponseData?.results?[indexPath.row].poster_path ?? "")
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesTypeCell.reusableIdentifier, for: indexPath) as! SeriesTypeCell
            
            cell.parentView.layer.cornerRadius = 16
            cell.seriesTypeLabel.text = tvSeriesList[indexPath.row]
            
            return cell
        }
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == todaysReleaseCollectionView {
            return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height)

        }else if (collectionView == tvSeriesListCollection){
            return CGSize(width: (collectionView.frame.width - 30) / 3, height: collectionView.frame.height)

        }
        else{
            return CGSize(width: (collectionView.frame.width - 30) / 3, height: (collectionView.frame.height - 20) / 2)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(tvSeriesList[indexPath.row] == "On Air"){
            observeEvents(seriesType: .onTheAir)
        }else if (tvSeriesList[indexPath.row] == "Popular"){
            observeEvents(seriesType: .popular)
        }else {
            observeEvents(seriesType: .topRated)
        }
            
    
        
    }
    

  
}
