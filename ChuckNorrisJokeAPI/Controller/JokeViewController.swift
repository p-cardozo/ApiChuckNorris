//
//  ViewController.swift
//  ChuckNorrisJokeAPI
//
//  Created by Patricia dos Santos Cardozo on 07/12/20.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    var changeJoke = ChangeJoke()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "\(TypeString.name)"
        textLabel.text = ""
        JokeREST.jokeRequest(onComplete: { (jokereturn) in
            let joke = jokereturn
            DispatchQueue.main.sync {
                self.textLabel.text = joke.value
                
            }
        }, onError: { (error) in
            print(error)
        }, categoria: TypeString.name)

    }
    
    
    @IBAction func changeButton(_ sender: UIButton) {
        changeJoke.getData {
            DispatchQueue.main.async {
                        self.textLabel.text = self.changeJoke.quote
        }
        }
        
}
}
