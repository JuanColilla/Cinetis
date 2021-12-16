//
//  FilterModalViewController.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 02/11/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class FilterModalViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var modalView: UIView!
    var darkBackgroundAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .linear)
    var lightBackgroundAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .linear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setEndAnimation()
        setUpGestureRecognizer()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        darkBackgroundAnimator.startAnimation()
    }
    
    func setUpView() {
        cancelButton.layer.cornerRadius = 10
        applyButton.layer.cornerRadius = 10
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    }
    func setUpGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func setEndAnimation() {
        darkBackgroundAnimator.addAnimations {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        lightBackgroundAnimator.addAnimations {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }
        lightBackgroundAnimator.addCompletion { _ in
            self.performSegue(withIdentifier: "unwindFilterModal", sender: self)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let tap = sender.location(in: self.view)
            if !modalView.frame.contains(tap) {
                lightBackgroundAnimator.startAnimation()
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        lightBackgroundAnimator.startAnimation()
    }
    @IBAction func applyButtonAction(_ sender: UIButton) {
        lightBackgroundAnimator.startAnimation()
    }
}
