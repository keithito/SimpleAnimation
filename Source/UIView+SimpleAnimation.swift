//
//  UIView+SimpleAnimation.swift
//  SimpleAnimation.swift
//
//  Created by Keith Ito on 4/19/16.
//

import UIKit


/**
  Edge of the view's parent that the animation should involve
  - None: involves no edge
  - Top: involves the top edge of the parent
  - Bottom: involves the bottom edge of the parent
  - Left: involves the left edge of the parent
  - Right: involves the right edge of the parent
 */
public enum SimpleAnimationEdge {
  case None
  case Top
  case Bottom
  case Left
  case Right
}

/**
  A UIView extension that makes adding basic animations, like fades and bounces, simple.
 */
public extension UIView {
  /**
    Fades this view in. This method can be chained with other animations to combine a fade with
    the other animation, for instance:
    ```
    view.fadeIn().slideIn(from: .Left)
    ```
    - Parameters:
      - duration: duration of the animation, in seconds
      - delay: delay before the animation starts, in seconds
      - completion: block executed when the animation ends
   */
  func fadeIn(duration: NSTimeInterval = 0.25,
              delay: NSTimeInterval = 0,
              completion: ((Bool) -> Void)? = nil) -> UIView {
    hidden = false
    alpha = 0
    UIView.animateWithDuration(
      duration, delay: delay, options: .CurveEaseInOut, animations: {
        self.alpha = 1
      }, completion: completion)
    return self
  }

  /**
   Fades this view out. This method can be chained with other animations to combine a fade with
   the other animation, for instance:
   ```
   view.fadeOut().slideOut(to: .Right)
   ```
   - Parameters:
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func fadeOut(duration: NSTimeInterval = 0.25,
               delay: NSTimeInterval = 0,
               completion: ((Bool) -> Void)? = nil) -> UIView {
    UIView.animateWithDuration(
      duration, delay: delay, options: .CurveEaseOut, animations: {
        self.alpha = 0
      }, completion: completion)
    return self
  }

  /**
   Slides this view into position, from an edge of the parent (if "from" is set) or a fixed offset
   away from its position (if "x" and "y" are set).
   - Parameters:
     - from: edge of the parent view that should be used as the starting point of the animation
     - x: horizontal offset that should be used for the starting point of the animation
     - y: vertical offset that should be used for the starting point of the animation
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func slideIn(from edge: SimpleAnimationEdge = .None,
                    x: CGFloat = 0,
                    y: CGFloat = 0,
                    duration: NSTimeInterval = 0.4,
                    delay: NSTimeInterval = 0,
                    completion: ((Bool) -> Void)? = nil) -> UIView {
    let offset = offsetForEdge(edge)
    transform = CGAffineTransformMakeTranslation(offset.x + x, offset.y + y)
    hidden = false
    UIView.animateWithDuration(
      duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 2,
      options: .CurveEaseOut, animations: {
        self.transform = CGAffineTransformIdentity
        self.alpha = 1
      }, completion: completion)
    return self
  }

  /**
   Slides this view out of its position, toward an edge of the parent (if "to" is set) or a fixed
   offset away from its position (if "x" and "y" are set).
   - Parameters:
     - to: edge of the parent view that should be used as the ending point of the animation
     - x: horizontal offset that should be used for the ending point of the animation
     - y: vertical offset that should be used for the ending point of the animation
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func slideOut(to edge: SimpleAnimationEdge = .None,
                   x: CGFloat = 0,
                   y: CGFloat = 0,
                   duration: NSTimeInterval = 0.25,
                   delay: NSTimeInterval = 0,
                   completion: ((Bool) -> Void)? = nil) -> UIView {
    let offset = offsetForEdge(edge)
    let endTransform = CGAffineTransformMakeTranslation(offset.x + x, offset.y + y)
    UIView.animateWithDuration(
      duration, delay: delay, options: .CurveEaseOut, animations: {
        self.transform = endTransform
      }, completion: completion)
    return self
  }

  /**
   Moves this view into position, with a bounce at the end, either from an edge of the parent (if
   "from" is set) or a fixed offset away from its position (if "x" and "y" are set).
   - Parameters:
     - from: edge of the parent view that should be used as the starting point of the animation
     - x: horizontal offset that should be used for the starting point of the animation
     - y: vertical offset that should be used for the starting point of the animation
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func bounceIn(from edge: SimpleAnimationEdge = .None,
                     x: CGFloat = 0,
                     y: CGFloat = 0,
                     duration: NSTimeInterval = 0.5,
                     delay: NSTimeInterval = 0,
                     completion: ((Bool) -> Void)? = nil) -> UIView {
    let offset = offsetForEdge(edge)
    transform = CGAffineTransformMakeTranslation(offset.x + x, offset.y + y)
    hidden = false
    UIView.animateWithDuration(
      duration, delay: delay, usingSpringWithDamping: 0.58, initialSpringVelocity: 3,
      options: .CurveEaseOut, animations: {
        self.transform = CGAffineTransformIdentity
        self.alpha = 1
      }, completion: completion)
    return self
  }

  /**
   Moves this view out of its position, starting with a bounce. The view moves toward an edge of
   the parent (if "to" is set) or a fixed offset away from its position (if "x" and "y" are set).
   - Parameters:
     - to: edge of the parent view that should be used as the ending point of the animation
     - x: horizontal offset that should be used for the ending point of the animation
     - y: vertical offset that should be used for the ending point of the animation
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func bounceOut(to edge: SimpleAnimationEdge = .None,
                    x: CGFloat = 0,
                    y: CGFloat = 0,
                    duration: NSTimeInterval = 0.35,
                    delay: NSTimeInterval = 0,
                    completion: ((Bool) -> Void)? = nil) -> UIView {
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
      }, completion: completion)
    return self
  }

  /**
   Moves this view into position, as though it were popping out of the screen.
   - Parameters:
     - fromScale: starting scale for the view, should be between 0 and 1
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func popIn(fromScale: CGFloat = 0.5,
             duration: NSTimeInterval = 0.5,
             delay: NSTimeInterval = 0,
             completion: ((Bool) -> Void)? = nil) -> UIView {
    hidden = false
    alpha = 0
    transform = CGAffineTransformMakeScale(fromScale, fromScale)
    UIView.animateWithDuration(
      duration, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
      options: .CurveEaseOut, animations: {
        self.transform = CGAffineTransformIdentity
        self.alpha = 1
      }, completion: completion)
    return self
  }

  /**
   Moves this view out of position, as though it were withdrawing into the screen.
   - Parameters:
     - toScale: ending scale for the view, should be between 0 and 1
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func popOut(toScale: CGFloat = 0.5,
              duration: NSTimeInterval = 0.3,
              delay: NSTimeInterval = 0,
              completion: ((Bool) -> Void)? = nil) -> UIView {
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
      }, completion: completion)
    return self
  }

  /**
   Causes the view to hop, either toward a particular edge or out of the screen (if "toward" is
   .None).
   - Parameters:
     - toward: the edge to hop toward, or .None to hop out
     - amount: distance to hop, expressed as a fraction of the view's size
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func hop(toward edge: SimpleAnimationEdge = .None,
                  amount: CGFloat = 0.4,
                  duration: NSTimeInterval = 0.6,
                  delay: NSTimeInterval = 0,
                  completion: ((Bool) -> Void)? = nil) -> UIView {
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
      }, completion: completion)
    return self
  }

  /**
   Causes the view to shake, either toward a particular edge or in all directions (if "toward" is
   .None).
   - Parameters:
     - toward: the edge to shake toward, or .None to shake in all directions
     - amount: distance to shake, expressed as a fraction of the view's size
     - duration: duration of the animation, in seconds
     - delay: delay before the animation starts, in seconds
     - completion: block executed when the animation ends
   */
  func shake(toward edge: SimpleAnimationEdge = .None,
                    amount: CGFloat = 0.15,
                    duration: NSTimeInterval = 0.6,
                    delay: NSTimeInterval = 0,
                    completion: ((Bool) -> Void)? = nil) -> UIView {
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
      }, completion: completion)
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
