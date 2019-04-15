//
//  MovieDetailViewController.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/6/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import UIKit
import SDWebImage
import ViewAnimator

class MovieDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var movie : Movie? = nil
    var movieImage : UIImage!
    private var MovieDetail : MovieDetail? = nil
    private var numberOfTrailers : Int = 1
    private let animation = AnimationType.from(direction: .top, offset: 30.0)
    private var time: TimeInterval = 0.3
    
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var lengthLabel: UILabel!
    @IBOutlet weak private var rateLabel: UILabel!
    @IBOutlet weak private var starImageView: UIImageView!
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        showMovieInformation()
        checkIfMovieFavorite()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MovieDetailViewController.checkIfMovieFavorite))
        tapGesture.numberOfTapsRequired = 1
        starImageView.isUserInteractionEnabled = true
        starImageView.addGestureRecognizer(tapGesture)
        self.navigationItem.title = Constants.strings.navegationBarTitle
        getMovieDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Rename back button
        let backButton = UIBarButtonItem(
            title: "",
            style: UIBarButtonItem.Style.plain, // Note: .Bordered is deprecated
            target: nil,
            action: nil
        )
        backButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        
    }
    
    func showMovieInformation(){
        guard let movie = movie else{return}
        titleLabel.text = movie.title
        yearLabel.text = String(movie.release_date.prefix(4))
        textView.text = movie.overview
        self.rateLabel.text = "\(movie.vote_average)/10"
        guard let imageUrl = URL(string:Constants.url.movieImageBaseUrlOriginal + movie.backdrop_path )else{return}
        movieImageView.sd_setImage(with: imageUrl)
        movieImageView.layer.borderColor = #colorLiteral(red: 0.2511725426, green: 0.5887399912, blue: 0.5322039723, alpha: 1)
        movieImageView.layer.borderWidth = Constants.strings.borderWidth
        movieImageView.animate(animations: [animation], duration: 1.0)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        checkIfMovieFavorite()
        UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.starImageView.isHidden = false
        }, completion: nil)
    }
    
    @objc func checkIfMovieFavorite(){
        //TODO : To save favorite state in Coredata or use any persistence tool
        guard let favorite = movie?.favorite else{
            starImageView.image = UIImage(named:Constants.strings.imageStarGray)
            movie?.favorite = false
            return
        }
        if !favorite{
            starImageView.image = UIImage(named:Constants.strings.imageStar)
            movie?.favorite = true
            starImageView.animate(animations: [animation], duration: 0.2)
        }else{
            starImageView.image = UIImage(named:Constants.strings.imageStarGray)
            movie?.favorite = false
        }
    }
    
    func getMovieDetail(){
        guard let movie = movie else{return}
        let strId = String(movie.id)
        WebServices.getMovieDetail(id: strId) {[weak self] (detailMovie, err) in
            DispatchQueue.main.async {
                guard let detail = detailMovie else{return}
                self?.lengthLabel.text = "\(detail.runtime!)min"
                self?.numberOfTrailers = detailMovie?.videos?.results!.count ?? 0
                self?.MovieDetail = detailMovie
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.strings.showYoutubeSegue {
            let cell = sender as! DetTableViewCell
            let indexPath = self.tableView!.indexPath(for: cell)
            let youtubeViewController = segue.destination as! YoutubeViewController
            youtubeViewController.youtubeId = (self.MovieDetail!.videos!.results![(indexPath!.row)].key)
        }
    }
    
    //MARK: Tableview implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfTrailers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.strings.cellId, for: indexPath) as? DetTableViewCell
        time += 0.15
        if time >= 3.3 {time = 1.0}
        cell?.detTextLabel.text = self.MovieDetail?.videos?.results![indexPath.row].name
        let animation = AnimationType.from(direction: .top, offset: 20.0)
        cell?.detImageView?.animate(animations: [animation], duration: time)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
