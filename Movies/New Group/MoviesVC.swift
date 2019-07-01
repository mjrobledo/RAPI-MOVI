//
//  ViewController.swift
//  Movies
//
//  Created by Miguel Robledo Vera on 06/06/19.
//  Copyright © 2019 Miguel Robledo Vera. All rights reserved.
//

import UIKit
import TMDBSwift
import ListPlaceholder

class MoviesVC: UIViewController , cellMovieDelegate{
    
    
    var categorys:[String] = []
    
    
    @IBOutlet weak var tblMovies: UITableView!
    var movies:[MovieMDB] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categorys = [.popular,.mostVoted,.upcoming]
        // Do any additional setup after loading the view, typically from a nib.
        
       // self.tblMovies.reloadData()
        //self.getPeliculas()
    }
    
    private func getPeliculas(){
        MovieMDB.popular(language: "ES", page: 1) { (apiReturn, movies) in
            if (movies?.count)! > 0{
                self.movies = movies!
                
            }
        }
    }
    
    // MARK - Delegados de celda
    func movieSelected(movie: MovieMDB) {
        self.performSegue(withIdentifier: "segueDetail", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueDetail"{
            let vc = segue.destination as! DetailVC
            vc.movie = (sender as! MovieMDB)
        }
    }
}


extension MoviesVC: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cellMovie
        //cell.initMovie(movies: movies)
        cell.initMovieIndex(category: categorys[indexPath.row])
        cell.delegateMovie = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}



struct categoryIndex {
    static let popular = 0
    static let mostVoted = 1
    static let upcoming = 2
}
