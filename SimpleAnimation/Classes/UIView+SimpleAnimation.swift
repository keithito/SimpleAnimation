//
//  UIView+SimpleAnimation.swift
//  SimpleAnimation.swift
//
//  Created by Keith Ito on 4/19/16.
//

import UIKit


public enum SimpleAnimationEdge {
  case None
  case Top
  case Bottom
  case Left
  case Right
}

public extension UIView {
  func fadeIn(duration: NSTimeInterval = 0.25,
              delay: NSTimeInterval = 0) -> UIView {
    hidden = false
    alpha = 0
    UIView.animateWithDuration(
      duration, delay: delay, options: .CurveEaseInOut, animations: {
        self.alpha = 1
      }, completion: nil)
    return self
  }

  func fadeOut(duration: NSTimeInterval = 0.25,
               delay: NSTimeInterval = 0) -> UIView {
    UIView.animateWithDuration(
      duration, delay: delay, options: .CurveEaseOut, animations: {
        self.alpha = 0
      }, completion: nil)
    return self
  }

  func slideIn(from edge: SimpleAnimationEdge = .None,
                    x: CGFloat = 0,
                    y: CGFloat = 0,
                    duration: NSTimeInterval = 0.4,
                    delay: NSTimeInterval = 0) -> UIView {
    let offset = offsetForEdge(edge)
    transform = CGAffineTransformMakeTranslation(offset.x + x, offset.y + y)
    hidden = false
    UIView.animateWithDuration(
      duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 2,
      options: .CurveEaseOut, animations: {
        self.transform = CGAffineTransformIdentity
        self.alpha = 1
      }, completion: nil)
    return self
  }

  func slideOut(to edge: SimpleAnimationEdge = .None,
                   x: CGFloat = 0,
                   y: CGFloat = 0,
                   duration: NSTimeInterval = 0.25,
                   delay: NSTimeInterval = 0) -> UIView {
    let offset = offsetForEdge(edge)
    let endTransform = CGAffineTransformMakeTranslation(offset.x + x, offset.y + y)
    UIView.animateWithDuration(
      duration, delay: delay, options: .CurveEaseOut, animations: {
        self.transform = endTransform
      }, completion: nil)
    return self
  }

  func bounceIn(from edge: SimpleAnimationEdge = .None,
                     x: CGFloat = 0,
                     y: CGFloat = 0,
                     duration: NSTimeInterval = 0.5,
                     delay: NSTimeInterval = 0) -> UIView {
    let offset = offsetForEdge(edge)
    transform = CGAffineTransformMakeTranslation(offset.x + x, offset.y + y)
    hidden = false
    UIView.animateWithDuration(
      duration, delay: delay, usingSpringWithDamping: 0.58, initialSpringVelocity: 3,
      options: .CurveEaseOut, animations: {
        self.transform = CGAffineTransformIdentity
        self.alpha = 1
      }, completion: nil)
    return self
  }

  func bounceOut(to edge: SimpleAnimationEdge = .None,
                    x: CGFloat = 0,
                    y: CGFloat = 0,
                    duration: NSTimeInterval = 0.35,
                    delay: NSTimeInterval = 0) -> UIView {
    let offset = offsetForEdge(edge)
    let delta = CGPoint(x: offset.x + x, y: offset.y + y)
    let endTransform = CGAffineTransformMakeTranslation(delta.x, delta.y)
    let prepareTransform = CGAffineTransformMakeTranslation(-delta.x * 0.2, -delta.y * 0.2)
    UIView.animateKeyframesWithDuration(
      duration, delay: delay, options: .CalculationModeCubic, animations: {
        UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2) {
          self.transform = prepareTransform
        }
        UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.2) {
          self.transform = prepareTransform
        }
        UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 0.6) {
          self.transform = endTransform
        }
      }, completion: nil)
    return self
  }

  func popIn(duration: NSTimeInterval = 0.5,
             delay: NSTimeInterval = 0,
             fromScale: CGFloat = 0.5) -> UIView {
    hidden = false
    alpha = 0
    transform = CGAffineTransformMakeScale(fromScale, fromScale)
    UIView.animateWithDuration(
      duration, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
      options: .CurveEaseOut, animations: {
        self.transform = CGAffineTransformIdentity
        self.alpha = 1
      }, completion: nil)
    return self
  }

  func popOut(duration: NSTimeInterval = 0.3,
              delay: NSTimeInterval = 0,
              toScale: CGFloat = 0.5) -> UIView {
    let endTransform = CGAffineTransformMakeScale(toScale, toScale)
    let prepareTransform = CGAffineTransformMakeScale(1.1, 1.1)
    UIView.animateKeyframesWithDuration(
      duration, delay: delay, options: .CalculationModeCubic, animations: {
        UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2) {
          self.transform = prepareTransform
        }
        UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.3) {
          self.transform = prepareTransform
        }
        UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
          self.transform = endTransform
          self.alpha = 0
        }
      }, completion: nil)
    return self
  }

  func hop(toward edge: SimpleAnimationEdge = .None,
                  amount: CGFloat = 0.4,
                  duration: NSTimeInterval = 0.6,
                  delay: NSTimeInterval = 0) -> UIView {
    var dx: CGFloat = 0, dy: CGFloat = 0, ds: CGFloat = 0
    if edge == .None {
      ds = amount / 2
    } else if edge == .Left || edge == .Right {
      dx = (edge == .Left ? -1 : 1) * self.bounds.size.width * amount;
      dy = 0
    } else {
      dx = 0
      dy = (edge == .Top ? -1 : 1) * self.bounds.size.height * amount;
    }
    UIView.animateKeyframesWithDuration(
      duration, delay: delay, options: .CalculationModeLinear, animations: {
        UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.28) {
          let t = CGAffineTransformMakeTranslation(dx, dy)
          self.transform = CGAffineTransformScale(t, 1 + ds, 1 + ds)
        }
        UIView.addKeyframeWithRelativeStartTime(0.28, relativeDuration: 0.28) {
          self.transform = CGAffineTransformIdentity
        }
        UIView.addKeyframeWithRelativeStartTime(0.56, relativeDuration: 0.28) {
          let t = CGAffineTransformMakeTranslation(dx * 0.5, dy * 0.5)
          self.transform = CGAffineTransformScale(t, 1 + ds * 0.5, 1 + ds * 0.5)
        }
        UIView.addKeyframeWithRelativeStartTime(0.84, relativeDuration: 0.16) {
          self.transform = CGAffineTransformIdentity
        }
      }, completion: nil)
    return self
  }

  func shake(toward edge: SimpleAnimationEdge = .None,
                    amount: CGFloat = 0.15,
                    duration: NSTimeInterval = 0.6,
                    delay: NSTimeInterval = 0) -> UIView {
    let steps = 8
    let timeStep = 1.0 / Double(steps)
    var dx: CGFloat, dy: CGFloat
    if edge == .Left || edge == .Right {
      dx = (edge == .Left ? -1 : 1) * self.bounds.size.width * amount;
      dy = 0
    } else {
      dx = 0
      dy = (edge == .Top ? -1 : 1) * self.bounds.size.height * amount;
    }
    UIView.animateKeyframesWithDuration(
      duration, delay: delay, options: .CalculationModeCubic, animations: {
        var start = 0.0
        for i in 0..<(steps - 1) {
          UIView.addKeyframeWithRelativeStartTime(start, relativeDuration: timeStep) {
            self.transform = CGAffineTransformMakeTranslation(dx, dy)
          }
          if (edge == .None && i % 2 == 0) {
            swap(&dx, &dy)  // Change direction
            dy *= -1
          }
          dx *= -0.85
          dy *= -0.85
          start += timeStep
        }
        UIView.addKeyframeWithRelativeStartTime(start, relativeDuration: timeStep) {
          self.transform = CGAffineTransformIdentity
        }
      }, completion: nil)
    return self
  }

  private func offsetForEdge(edge: SimpleAnimationEdge) -> CGPoint {
    if let parentSize = self.superview?.frame.size {
      switch edge {
      case .None: return CGPointZero
      case .Top: return CGPoint(x: 0, y: -CGRectGetMaxY(frame))
      case .Bottom: return CGPoint(x: 0, y: parentSize.height - CGRectGetMinY(frame))
      case .Left: return CGPoint(x: -CGRectGetMaxX(frame), y: 0)
      case .Right: return CGPoint(x: parentSize.width - CGRectGetMinX(frame), y: 0)
      }
    }
    return CGPointZero
  }
}
