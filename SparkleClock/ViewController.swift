//
//  ViewController.swift
//  SparkleClock
//
//  Created by Aaron Douglas on 12/5/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var timer: Timer!
    var dateFormatter: DateFormatter!
    @IBOutlet var clockLabel: UILabel!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var shimmeringView: FBShimmeringView!

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateClock), userInfo: nil, repeats: true)
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        shimmeringView.contentView = clockLabel
        shimmeringView.isShimmering = true

        //Optional ShimmeringView protocal values
        //All values show are the defaults
        shimmeringView.shimmeringPauseDuration = 0.4
        shimmeringView.shimmeringAnimationOpacity = 0.5
        shimmeringView.shimmeringOpacity = 1.0
        shimmeringView.shimmeringSpeed = 230
        shimmeringView.shimmeringHighlightLength = 1.0
        shimmeringView.shimmeringDirection = FBShimmerDirection.right

        //All possible directional values
        //FBShimmerDirection.Right,  Shimmer animation goes from left to right
        //FBShimmerDirection.Left,  Shimmer animation goes from right to left
        //FBShimmerDirection.Up,  Shimmer animation goes from below to above
        //FBShimmerDirection.Down,  Shimmer animation goes from above to below

        shimmeringView.shimmeringBeginFadeDuration = 0.1
        shimmeringView.shimmeringEndFadeDuration = 0.3
    }

    override func viewWillAppear(_ animated: Bool) {
        updateClock()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        UIApplication.shared.isIdleTimerDisabled = false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func updateClock() {
        let timeToDisplay = dateFormatter.string(from: NSDate() as Date)
        clockLabel.text = timeToDisplay
    }

    @IBAction func didTapView() {
        tapGestureRecognizer.isEnabled = false
        shimmeringView.isShimmering = !shimmeringView.isShimmering

        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.clockLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: 0.25, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.clockLabel.transform = .identity
            }, completion: {
                (finished) -> Void in
                self.tapGestureRecognizer.isEnabled = true
            })
        })
    }
}
