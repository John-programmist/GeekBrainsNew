
import UIKit
@IBDesignable class GradientView: UIView {
    
    @IBInspectable
    var startColor: UIColor = .link{
        didSet{
            updateColor()
        }
    }
    
    @IBInspectable
    var endColor: UIColor = .systemGreen{
        didSet{
            updateColor()
        }
    }
    
    @IBInspectable
    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0){
        didSet{
            gradient.startPoint = startPoint
        }
    }
    
    @IBInspectable
    var endPoint: CGPoint = CGPoint(x: 0.5, y: 1){
        didSet{
            gradient.endPoint = endPoint
        }
    }

    override static var layerClass: AnyClass{
        return CAGradientLayer.self
    }
    
    var gradient: CAGradientLayer{
        return self.layer as! CAGradientLayer
    }
    
    func updateColor(){
        gradient.colors = [startColor.cgColor, endColor.cgColor]
    }
    
}
