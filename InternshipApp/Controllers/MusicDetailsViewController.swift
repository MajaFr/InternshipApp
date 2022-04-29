//
//  MusicDetailsViewController.swift
//  InternshipApp
//
//  Created by Maja Frąk on 28/04/2022.
//

import UIKit

class MusicDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var words: [RandomWord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FoundRecordingTableViewCell", bundle: nil), forCellReuseIdentifier: "FoundRecordingCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MusicDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.word = words[indexPath.row]
        presentFullScreen(viewController: detailsVC)
    }
}

extension MusicDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoundRecordingCell", for: indexPath) as? FoundRecordingTableViewCell else {
            return UITableViewCell()
        }
        
        let word = words[indexPath.row]
        cell.songTitleLabel.text = word.word
        return cell
    }
}
