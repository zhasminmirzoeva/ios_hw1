//
//  ViewController.swift
//  zhmmirzoeva_PW1
//
//  Created by admin on 27/09/22.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet var views: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        let button = sender as? UIButton
        button?.isEnabled = false
        UIView.animate(withDuration: 2, animations: {
            for view in self.views {
                view.layer.cornerRadius = 10
                view.backgroundColor = set.popFirst()
            }
        }) {completion in button?.isEnabled = true
        }
    }
}
