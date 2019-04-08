//
//  CatalogUICoCollectionViewController.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/4/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import UIKit
import SDWebImage
import ViewAnimator

let SHOW_DETAIL: String = "showDetail"
let PLACE_HOLDER: String = "placeholder.jpg"
let NAVEGATION_TITLE_RATED: String = "Higher Audience"
let NAVEGATION_TITLE_POPULAR: String = "Popular"

private let reuseIdentifier = "Cell"

class CatalogUICoCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var movies: [Movie] = []
    var placeHolder: UIImage!
    var imageArrayUrl: [URL] = []
    let animationImage = UIImageView()
    var titleBar: String?
    var isTopRated = true
    var movieImage = UIImage()
    var time: TimeInterval = 1.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies(isTopRated: isTopRated)
        placeHolder = UIImage(named: PLACE_HOLDER)
        //Set navigation initial configuration
        self.navigationItem.title = NAVEGATION_TITLE_RATED
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieCollectionViewCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func getMovies(isTopRated: Bool){
        //Request to get movies as topRated as default
        WebServices.getMovies(isTopRated:isTopRated) { (movies,err) in
            if (err == nil) {
                self.movies = movies!
                for movie in movies! {
                    guard let url = URL(string:Constants.url.movieImageBaseUrlw780 + movie.backdrop_path ) else{return}
                    self.imageArrayUrl.append(url)
                }
                DispatchQueue.main.async{
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SHOW_DETAIL {
            let cell = sender as! MovieCollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            let detailViewController = segue.destination as! MovieDetailViewController
            detailViewController.movie = self.movies[(indexPath?.row)!]
            detailViewController.movieImage = self.movieImage
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        time += 0.15
        if time >= 3.3 {time = 1.0}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        var movie = movies[indexPath.row]
        let imageURL = Constants.url.movieImageBaseUrlw780 + movie.backdrop_path
        let url = URL(string: imageURL)
        
        //**** SDWebImage pod is saveving/caching in memory and it help us to avoid download each image again.
        cell.movieImageView?.sd_setImage(with: url)
        movieImage = cell.movieImageView?.image ?? UIImage()
        if movie.favorite == nil {movie.favorite = false}
        let animation = AnimationType.from(direction: .top, offset: 20.0)
        cell.movieImageView?.animate(animations: [animation], duration: time)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.view.frame.size.height/4;
        let width  = self.view.frame.size.width/2;
        return CGSize(width:width  , height: height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }, completion: nil)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }, completion: nil)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        if isTopRated  {
            isTopRated = false
            self.navigationItem.title = NAVEGATION_TITLE_POPULAR
            self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2511725426, green: 0.5887399912, blue: 0.5322039723, alpha: 1)
        }else{
            isTopRated = true
            self.navigationItem.title = NAVEGATION_TITLE_RATED
            self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        getMovies(isTopRated: isTopRated)
    }
    
}
