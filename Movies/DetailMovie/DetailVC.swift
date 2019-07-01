//
//  DetailVC.swift
//  Movies
//
//  Created by Miguel Robledo Vera on 07/06/19.
//  Copyright © 2019 Miguel Robledo Vera. All rights reserved.
//

import UIKit
import TMDBSwift

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movie:MovieMDB!
    var movieDetail:MovieMDB!
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var imgMovieHeader: UIImageView!
    
    @IBOutlet weak var tblMovies: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if movie != nil {
           
            self.imgMovieHeader.downloaded(from: "\(movie.backdrop_path!.getUrlImage())")
            self.imgMovie.downloaded(from: "\(movie.poster_path!.getUrlImage())")
            
            MovieMDB.movie(movieID: movie.id, language: Constants.language) { (clientReturn, movieDetail) in
                self.movieDetail = movieDetail
                 self.tblMovies.reloadData()
            }
        }
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if movieDetail != nil && movieDetail.overview != ""{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSinopsis")
            let txtSinopsis = cell?.viewWithTag(1) as! UITextView
            txtSinopsis.text = movieDetail.overview
            return cell!
        case 0:
            return cellTitle(indexPath: indexPath)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellImage")
            let image = cell?.viewWithTag(1) as! UIImageView
            
            image.downloaded(from: "\(Constants.urlImage)\(movie.backdrop_path!)")
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellImage")
        let image = cell?.viewWithTag(1) as! UIImageView
        
        image.downloaded(from: "\(Constants.urlImage)\(movie.backdrop_path!)")
        return cell!
    }
    
    private func cellTitle( indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMovies.dequeueReusableCell(withIdentifier: "cellTitle", for: indexPath)
        let lblTitle = cell.viewWithTag(1) as! UILabel
        let lblGenere = cell.viewWithTag(2) as! UILabel
        lblTitle.text = movie.title
        lblGenere.text = "Popular/\(movie.vote_count) votos"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 180
        case 1:
            return 250
        default:
            return 80
            
        }
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    func getUrlImage() -> String{
        return "\(Constants.urlImage)\(self)"
    }
}
