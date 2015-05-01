
import UIKit

class ViewController: UIViewController , UICollisionBehaviorDelegate {

    //let bottomBoundary = "bottomBoundary"
    var squareLabel : UILabel?
    var usingAnimator: UIDynamicAnimator?
    var pushBehavior: UIPushBehavior?
    
    func createSmallSquareView() {
        
        squareLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareLabel!.backgroundColor = UIColor.orangeColor()
        view.addSubview(squareLabel!)
    }
    
    func createGestureRexognizer() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func createAnimatorAndBehavior() {
        
        usingAnimator = UIDynamicAnimator(referenceView: view)
        
        if let theSquareLabel = squareLabel {
            
            let collision = UICollisionBehavior(items: [theSquareLabel])
            collision.translatesReferenceBoundsIntoBoundary = true
            pushBehavior = UIPushBehavior(items: [theSquareLabel], mode: UIPushBehaviorMode.Continuous)
            usingAnimator?.addBehavior(collision)
            usingAnimator?.addBehavior(pushBehavior)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createGestureRexognizer()
        createSmallSquareView()
        createAnimatorAndBehavior()
    }
    
    
    func handleTap(tap: UITapGestureRecognizer) {
        
        let tapPoint = tap.locationInView(view)
        let squareLabelCenterPoint = self.squareLabel!.center
        let deltaX = tapPoint.x - squareLabelCenterPoint.x
        let deltaY = tapPoint.y - squareLabelCenterPoint.y
        let angle = atan2(deltaY, deltaX)
        
        pushBehavior?.angle = angle
        
        let distanceBetweenPoints = sqrt(pow(tapPoint.x - squareLabelCenterPoint.x,2.0) + pow(tapPoint.y - squareLabelCenterPoint.y, 2.0))
        
        pushBehavior?.magnitude = distanceBetweenPoints / 200.0
    }
    
    
    /*func collisionBehavior(behavior: UICollisionBehaviorMode.Type , beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {

        if identifier as? String == bottomBoundary {

            UILabel.animateWithDuration(1, animations: {
                
                let label = item as UILabel
                label.backgroundColor = UIColor.orangeColor()
                label.alpha = 0
                label.transform = CGAffineTransformMakeScale(2, 2)
                }, completion: {(finished: Bool) in
                    
                    let label = item as UILabel
                    //behavior.removeItem(item)
                    behavior.Boundaries
                    label.removeFromSuperview()
            })
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let colors = [UIColor.yellowColor(), UIColor.purpleColor()]

        var x: CGFloat = 120
        var y: CGFloat = 30

        for counter in 0..<2 {
            let newView = UILabel(frame: CGRect(x: x, y: y, width: 70, height: 50))
            newView.backgroundColor = colors[counter]
            squareLabel.append(newView)
            view.addSubview(newView)
            x=x+50
            y=y+80
        }

        usingAnimator = UIDynamicAnimator(referenceView: self.view)
        let gravity = UIGravityBehavior(items: squareLabel)
        usingAnimator?.addBehavior(gravity)
        let usingCollisionBehaviour = UICollisionBehavior(items: squareLabel)
        let fromPoint = CGPoint(x: 0, y: view.bounds.size.height - 50)
        let toPoint = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height - 50)
        //usingCollisionBehaviour.addBoundaryWithIdentifier(bottomBoundary, fromPoint: fromPoint, toPoint: toPoint)
        usingCollisionBehaviour.translatesReferenceBoundsIntoBoundary = true
        usingCollisionBehaviour.collisionDelegate = self
        usingAnimator?.addBehavior(usingCollisionBehaviour)
    }*/
}

