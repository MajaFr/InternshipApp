//
//  DetailsViewController.swift
//  InternshipApp
//
//  Created by Maja Frąk on 29/04/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var word: RandomWord?
    var music: Music?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
    }
    
    @IBAction func backButtonTaped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController {
    func downloadData() {
        guard let title = word?.word else { return }
        let jsonUrlString = "https://musicbrainz.org/ws/2/recording/?query=title:\(title)&fmt=json"
    
        guard let url = URL(string: jsonUrlString) else { return }
    
        URLSession.shared.dataTask(with: url) { [weak self] data, response, err in
            guard let self = self else { return }
            guard let data = data else { return }
            do {
                let music = try JSONDecoder().decode(Music.self, from: data)
                self.music = music
                
                DispatchQueue.main.async {
                    self.loadData()
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }.resume()
    }
    
    func loadData() {
        guard let record = music?.recordings.first else { return }
        titleLabel.text = record.title
        artistLabel.text = record.artistCredit.first?.name
        albumLabel.text = record.releases.first?.title
    }
    
}



