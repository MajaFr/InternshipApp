//
//  DrawWordsViewController.swift
//  InternshipApp
//
//  Created by Maja Frąk on 28/04/2022.
//

import UIKit

class DrawWordsViewController: UIViewController {
    
    @IBOutlet weak var drawNumberTextField: UITextField!
    @IBOutlet weak var drawButton: UIButton!
    
    var words: [RandomWord] = [] {
        didSet {
            if words.count == drawNumberInt && !words.isEmpty {
                drawButton.isEnabled = true
                let musicVC = MusicDetailsViewController()
                musicVC.words = words
                
                presentFullScreen(viewController: musicVC)
            }
        }
    }
    
    var drawNumberInt: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        words = []
        guard let drawNumberString = drawNumberTextField.text else {
            return
        }
        guard let drawNumberInt = Int(drawNumberString) else {
            return
        }
        
        if drawNumberInt >= 1 && drawNumberInt <= 10 {
            drawButton.isEnabled = false
            self.drawNumberInt = drawNumberInt
            
            for _ in 1...drawNumberInt {
                downloadWord()
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Invalid number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        
    }
    
    func downloadWord() {
        let jsonUrlString = "https://random-words-api.vercel.app/word"
        guard let url = URL(string: jsonUrlString) else {
            drawButton.isEnabled = true
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, err in
            guard let self = self else { return }
            guard let data = data else {
                self.drawButton.isEnabled = true
                return
            }
            
            do {
                let words = try JSONDecoder().decode([RandomWord].self, from: data)
                guard let word = words.first else {
                    self.drawButton.isEnabled = true
                    return
                }
                
                DispatchQueue.main.async {
                    self.words.append(word)
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.drawButton.isEnabled = true
                }
                print("\(error.localizedDescription)")
            }
        }.resume()
    }
}
