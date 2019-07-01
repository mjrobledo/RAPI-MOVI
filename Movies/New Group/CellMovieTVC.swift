//
//  CellMovieTVC.swift
//  Movies
//
//  Created by Miguel Robledo Vera on 07/06/19.
//  Copyright © 2019 Miguel Robledo Vera. All rights reserved.
//

import UIKit
import TMDBSwift

protocol cellMovieDelegate {
    func movieSelected(movie:MovieMDB)
}

class cellMovie: UITableViewCell {
   

    
@IBOutlet weak var collMovies: UICollectionView!
@IBOutlet weak var lblCategory: UILabel!
    var delegateMovie:cellMovieDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var movies:[MovieMDB] = []
    
    
    func initMovieIndex(category:String){
        collMovies.delegate = self
        collMovies.dataSource = self
        lblCategory.text = category
        
        switch category {
        case .popular:
            self.loadPopular()
        case .mostVoted:
            self.loadTopRated()
        case .upcoming:
            self.loadUpcoming()
            
        default:
            print("None")
        }
        
        
    }
    
    
    private func  loadPopular(){
        MovieMDB.popular(language: Constants.language, page: 1) { (clientReturn, movies) in
            if movies?.count != 0{
                self.movies = movies!
                self.collMovies.reloadData()
            }else{
                
            }
        }
    }
    
    private func  loadTopRated(){
        MovieMDB.toprated(language: Constants.language, page: 1) { (clientReturn, movies) in
            if movies?.count != 0{
                self.movies = movies!
                self.collMovies.reloadData()
            }else{
                
            }
        }
    }
    
    private func  loadUpcoming(){
        MovieMDB.upcoming(page: 1, language: Constants.language, completion: {  (clientReturn, movies) in
            if movies?.count != 0{
                self.movies = movies!
                self.collMovies.reloadData()
            }else{
                
            }
        })
    }
    
    
}


extension cellMovie : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  movies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            let imageView = cell.viewWithTag(1) as! UIImageView
            let imageVideo = cell.viewWithTag(2) as! UIImageView
            
            imageVideo.isHidden = !movies[indexPath.row].video!
            
            let urlMovie:String = "\(Constants.urlImage)\(movies[indexPath.row].poster_path!)"
            imageView.downloaded(from: urlMovie)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellsAcross: CGFloat = 3.3
            
            let spaceBetweenCells: CGFloat = 2
            let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: dim, height: collectionView.bounds.height)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegateMovie.movieSelected(movie: movies[indexPath.row])
    }

}

enum category {
    case popular
    case topRated
    case upcoming
}
