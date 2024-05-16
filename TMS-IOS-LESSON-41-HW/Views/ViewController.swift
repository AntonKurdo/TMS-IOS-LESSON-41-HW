import UIKit
import CoreMotion

class ViewController: UIViewController {
    let manager = CMMotionManager()
    
    lazy var circleView: UIView = {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 120, height: 120))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 60
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        self.view.addSubview(view)
        return view
    }()
    
    var circleCentre : CGPoint!
    var newCircleCentre : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        manager.startAccelerometerUpdates()
        
        circleCentre = self.circleView.center
        newCircleCentre = self.circleView.center
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if let data = self.manager.accelerometerData {
                self.newCircleCentre.x = (CGFloat(data.acceleration.x) * 17)
                self.newCircleCentre.y = (CGFloat(data.acceleration.y) * -17)
                
                if abs(self.newCircleCentre.x) + abs(self.newCircleCentre.y) < 1.0 {
                    self.newCircleCentre = .zero
                }
                
                self.circleCentre = CGPoint(x: self.circleCentre.x + self.newCircleCentre.x, y: self.circleCentre.y + self.newCircleCentre.y)
                
                self.circleCentre.x = max(self.circleView.frame.size.width*0.5, min(self.circleCentre.x, self.view.bounds.width - self.circleView.frame.size.width*0.5))
                self.circleCentre.y = max(self.circleView.frame.size.height*0.5, min(self.circleCentre.y, self.view.bounds.height - self.circleView.frame.size.height*0.5))
                
                self.circleView.center = self.circleCentre
            }
        }
    }
}

