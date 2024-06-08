//
//  ViewAllViewController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 08/06/24.
//

import UIKit

class ViewAllViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var moviesResponse : CommonMovieModel?
    
    
    
    @IBOutlet weak var collectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MoviesCollectionCell.nib(), forCellWithReuseIdentifier: MoviesCollectionCell.reusableIdentifier)

      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.reusableIdentifier, for: indexPath) as! MoviesCollectionCell
        
        cell.parentView.clipsToBounds = true
        cell.parentView.layer.cornerRadius = 16
        cell.moviesImage.setImage(with: moviesResponse?.results?[indexPath.row].poster_path ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesResponse?.results?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ( collectionView.frame.width - 30 ) / 3, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected")
    }

    

}
