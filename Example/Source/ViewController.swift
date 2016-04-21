//
//  ViewController.swift
//  SimpleAnimation
//
//  Created by Keith Ito on 04/18/2016.
//  Copyright (c) 2016 Keith Ito. All rights reserved.
//

import SimpleAnimation
import UIKit

private enum AnimationExampleType: String {
  case FadeIn = "fadeIn()"
  case FadeOut = "fadeOut()"
  case PopIn = "popIn()"
  case PopOut = "popOut()"
  case SlideInFromTop = "slideIn(from: .Top)"
  case SlideInFromBottom = "slideIn(from: .Bottom)"
  case SlideInFromLeft = "slideIn(from: .Left)"
  case SlideInFromRight = "slideIn(from: .Right)"
  case SlideOutToTop = "slideOut(to: .Top)"
  case SlideOutToBottom = "slideOut(to: .Bottom)"
  case SlideOutToLeft = "slideOut(to: .Left)"
  case SlideOutToRight = "slideOut(to: .Right)"
  case BounceInFromTop = "bounceIn(from: .Top)"
  case BounceInFromBottom = "bounceIn(from: .Bottom)"
  case BounceInFromLeft = "bounceIn(from: .Left)"
  case BounceInFromRight = "bounceIn(from: .Right)"
  case BounceOutToTop = "bounceOut(to: .Top)"
  case BounceOutToBottom = "bounceOut(to: .Bottom)"
  case BounceOutToLeft = "bounceOut(to: .Left)"
  case BounceOutToRight = "bounceOut(to: .Right)"
  case Shake = "shake()"
  case ShakeTowardLeft = "shake(toward: .Left)"
  case ShakeTowardTop = "shake(toward: .Top)"
  case Hop = "hop()"
  case HopTowardTop = "hop(toward: .Top)"
  case HopTowardBottom = "hop(toward: .Bottom)"
  case HopTowardLeft = "hop(toward: .Left)"
  case HopTowardRight = "hop(toward: .Right)"
}

private let AllExamples: [AnimationExampleType] = [
  .FadeIn,
  .FadeOut,
  .PopIn,
  .PopOut,
  .SlideInFromTop,
  .SlideInFromBottom,
  .SlideInFromLeft,
  .SlideInFromRight,
  .SlideOutToTop,
  .SlideOutToBottom,
  .SlideOutToLeft,
  .SlideOutToRight,
  .BounceInFromTop,
  .BounceInFromBottom,
  .BounceInFromLeft,
  .BounceInFromRight,
  .BounceOutToTop,
  .BounceOutToBottom,
  .BounceOutToLeft,
  .BounceOutToRight,
  .Shake,
  .ShakeTowardLeft,
  .ShakeTowardTop,
  .Hop,
  .HopTowardTop,
  .HopTowardBottom,
  .HopTowardLeft,
  .HopTowardRight,
]

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  @IBOutlet weak var animatedView: UIView!
  @IBOutlet weak var typePicker: UIPickerView!
  @IBOutlet weak var startButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    animatedView.layer.cornerRadius = 20
  }

  @IBAction func startButtonPressed(sender: AnyObject) {
    startAnimation(AllExamples[typePicker.selectedRowInComponent(0)])
  }

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(view: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return AllExamples.count
  }

  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int,
                  reusingView view: UIView?) -> UIView {
    let label = UILabel()
    label.text = AllExamples[row].rawValue
    label.font = UIFont(name: "Courier", size: 15)
    label.textAlignment = NSTextAlignment.Center
    label.textColor = UIColor.blackColor()
    return label
  }

  private func startAnimation(type: AnimationExampleType) {
    animatedView.transform = CGAffineTransformIdentity
    switch (type) {
    case .FadeIn:
      animatedView.fadeIn()
    case .FadeOut:
      animatedView.alpha = 1
      animatedView.fadeOut()
    case .PopIn:
      animatedView.popIn()
    case .PopOut:
      animatedView.alpha = 1
      animatedView.popOut()
    case .SlideInFromTop:
      animatedView.slideIn(from: .Top)
    case .SlideInFromBottom:
      animatedView.slideIn(from: .Bottom)
    case .SlideInFromLeft:
      animatedView.slideIn(from: .Left)
    case .SlideInFromRight:
      animatedView.slideIn(from: .Right)
    case .SlideOutToTop:
      animatedView.alpha = 1
      animatedView.slideOut(to: .Top)
    case .SlideOutToBottom:
      animatedView.alpha = 1
      animatedView.slideOut(to: .Bottom)
    case .SlideOutToLeft:
      animatedView.alpha = 1
      animatedView.slideOut(to: .Left)
    case .SlideOutToRight:
      animatedView.alpha = 1
      animatedView.slideOut(to: .Right)
    case .BounceInFromTop:
      animatedView.bounceIn(from: .Top)
    case .BounceInFromBottom:
      animatedView.bounceIn(from: .Bottom)
    case .BounceInFromLeft:
      animatedView.bounceIn(from: .Left)
    case .BounceInFromRight:
      animatedView.bounceIn(from: .Right)
    case .BounceOutToTop:
      animatedView.alpha = 1
      animatedView.bounceOut(to: .Top)
    case .BounceOutToBottom:
      animatedView.alpha = 1
      animatedView.bounceOut(to: .Bottom)
    case .BounceOutToLeft:
      animatedView.bounceOut(to: .Left)
      animatedView.alpha = 1
    case .BounceOutToRight:
      animatedView.alpha = 1
      animatedView.bounceOut(to: .Right)
    case .Shake:
      animatedView.alpha = 1
      animatedView.shake()
    case .ShakeTowardLeft:
      animatedView.alpha = 1
      animatedView.shake(toward: .Left)
    case .ShakeTowardTop:
      animatedView.alpha = 1
      animatedView.shake(toward: .Top)
    case .Hop:
      animatedView.alpha = 1
      animatedView.hop()
    case .HopTowardTop:
      animatedView.alpha = 1
      animatedView.hop(toward: .Top)
    case .HopTowardBottom:
      animatedView.alpha = 1
      animatedView.hop(toward: .Bottom)
    case .HopTowardLeft:
      animatedView.alpha = 1
      animatedView.hop(toward: .Left)
    case .HopTowardRight:
      animatedView.alpha = 1
      animatedView.hop(toward: .Right)
    }
  }
}

