//
//  ViewController.swift
//  ios_hw2
//
//  Created by Zhasmin Mirzoeva on 09.10.2022.
//

import UIKit

class ViewController: UIViewController {
    private let commantLabel = UILabel()
    private let valueLabel = UILabel()
    var value: Int = 0
    let incrementButton = UIButton()
    var commentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pinLeft(to: self.view, 24)
        incrementButton.pinRight(to: self.view, 24)
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinButton(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    
    private func setupView() {
        commentView = setupCommentView()
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 1) {
            self.updateCommentLabel(value: self.value)
            self.setupValueLabel()
        }
    }
    
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(to: self.view, 24)
        commentView.pinRight(to: self.view, 24)
        commantLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commantLabel.textColor = .systemGray
        commantLabel.numberOfLines = 0
        commantLabel.textAlignment = .center
        commentView.addSubview(commantLabel)
        commantLabel.pinLeft(to: commentView, 16)
        commantLabel.pinRight(to: commentView, 16)
        commantLabel.pinTop(to: commentView, 16)
        commantLabel.pinBottom(to: commentView, 16)
        return commentView
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commantLabel.text = "1"
        case 10...20:
            commantLabel.text = "2"
        case 20...30:
            commantLabel.text = "3"
        case 30...40:
            commantLabel.text = "4"
        case 40...50:
            commantLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commantLabel.text = "big boy"
        case 6...70:
            commantLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commantLabel.text = "🌟🌟🌟🌟🌟🌟🌟🌟🌟"
        case 80...90:
            commantLabel.text = "80+\n go higher"
        case 90...100:
            commantLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
    private func makeMenubutton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenubutton(title: "🎨")
        let notesButton = makeMenubutton(title: "📝")
        let newsButton = makeMenubutton(title: "📰")
        let buttonSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonSV.spacing = 12
        buttonSV.axis = .horizontal
        buttonSV.distribution = .fillEqually
        self.view.addSubview(buttonSV)
        buttonSV.pinLeft(to: self.view, 10)
        buttonSV.pinRight(to: self.view, 10)
        buttonSV.pinButton(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
}

extension UIButton {
     public func applyShadow() {
         layer.shadowColor = UIColor.black.cgColor
         layer.shadowOpacity = 1
         layer.shadowOffset = .zero
         layer.shadowRadius = 7
    }
}




