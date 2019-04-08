//
//  YoutubeViewController.swift
//  CodeTestEmmanuelCepeda
//
//  Created by Juan Cepeda on 4/8/19.
//  Copyright © 2019 Juan Cepeda. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

let YOUTUBE_NAVEGATION_BAR_TITLE = "Youtube"

class YoutubeViewController: UIViewController, YTPlayerViewDelegate{
    
    var youtubeId : String = ""
    
    @IBOutlet weak var youtubeView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.youtubeView.delegate = self
        self.youtubeView.load(withVideoId: String(youtubeId))
        self.youtubeView.playVideo()
        // Do any additional setup after loading the view.
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
        self.navigationItem.title = YOUTUBE_NAVEGATION_BAR_TITLE
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
