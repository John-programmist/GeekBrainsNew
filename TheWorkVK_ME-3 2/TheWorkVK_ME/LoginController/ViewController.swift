//
//  ViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 23.11.2021.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var gradiend: GradientView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var backgroundOfLogIn: UIView!{
        didSet{
            backgroundOfLogIn.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var animateView: GradientView!
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //runAnimate()
        //transitionGradiend()
        animationLabels()
        Cloud()
        
        UIView.transition(with: animateView, duration: 1, options: [.repeat, .autoreverse, .transitionCrossDissolve], animations: {
//            NSLayoutConstraint.activate([
//                self.animateView.bottomAnchor.constraint(equalTo: self.animateView.bottomAnchor)
//            ])
            
            self.animateView.startPoint = CGPoint(x: 0, y: 0)
            self.animateView.endPoint = CGPoint(x: 1, y: 1)
            self.animateView.startColor = .cyan
            self.animateView.endColor = .systemGreen
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification){
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let kbSize = notification.userInfo?[key] as? CGRect else {return}
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification: Notification){
        
    }
    
    @IBAction func scrollTap(_sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
        
        let result = checkUserData()
        
        let result1 = checkPass()
        
        if !result1{
            showLoginAndPasswordError(Answer: !result1)
        }
        
        if !result{
            showLoginAndPasswordError(Answer: result)
        }
        
        return result
        
    }
    
    func checkPass()->Bool{
        guard let pass1 = password1.text, let pass2 = password2.text
        else{ return false }
        if pass1 == pass2{
            return true
        }
        else{
            return false
        }
    }
    
    func checkUserData() -> Bool {
           guard let login = login.text,
               let password = password1.text else { return false }
           
        if login.count >= 10 && password.count >= 10 {
               return true
           } else {
               return false
           }
       }

    
    func showLoginAndPasswordError(Answer: Bool){
        if(Answer){
            let alter = UIAlertController(title: "Error", message: "These passwords don't match\nPassword: "+password1.text!+"\nConfirmPassword: "+password2.text!, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alter.addAction(action)
            present(alter, animated: true, completion: nil)
        }
        else{
            let alter = UIAlertController(title: "Error", message: "Invalid login or password. Please enter more than 10 symbols", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alter.addAction(action)
            present(alter, animated: true, completion: nil)
        }
    }
    
    
//    func runAnimate(){
//        UIView.animate(withDuration: 1){
//            self.gradiend.startPoint = CGPoint(x: 0.5, y: 0)
//            self.gradiend.endPoint = CGPoint(x: 0.5, y: 1)
//            self.gradiend.startColor = .purple
//            self.gradiend.endColor = .red
//        } completion: { _ in
//            self.revertAnimate()
//        }
//    }
//
//    func revertAnimate(){
//        UIView.animate(withDuration: 1, delay: 1, options: [.repeat, .autoreverse, .transitionCurlUp], animations: {
//            self.gradiend.startPoint = CGPoint(x: 0.5, y: 0)
//            self.gradiend.endPoint = CGPoint(x: 0.5, y: 1)
//            self.gradiend.endColor = .systemGreen
//            self.gradiend.startColor = .link
//        }, completion: nil)
//    }
    
    func animationLabels(){
        let loginTap = UITapGestureRecognizer(target: self, action: #selector(GroupAnimationLogin(_:)))
        let passTap = UITapGestureRecognizer(target: self, action: #selector(GroupAnimationPass(_:)))
        
        loginLabel.addGestureRecognizer(loginTap)
        passLabel.addGestureRecognizer(passTap)
        
        
    }
    
    
    func transitionGradiend(){
        UIView.transition(with: gradiend, duration: 1, options: [.repeat, .autoreverse, .transitionCrossDissolve], animations: {
            self.gradiend.startPoint = CGPoint(x: 0.5, y: 0)
            self.gradiend.endPoint = CGPoint(x: 0.5, y: 1)
            self.gradiend.startColor = .purple
            self.gradiend.endColor = .red
        })
    }
    
    
    @objc func GroupAnimationLogin(_ recognizer: UITapGestureRecognizer){
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 100
        scaleAnimation.mass = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.beginTime = CACurrentMediaTime() + 1
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.animations = [opacity, scaleAnimation]
        loginLabel.layer.add(animationGroup, forKey: nil)
    }
    
    
    
    @objc func GroupAnimationPass(_ recognizer: UITapGestureRecognizer){
        propertyAnimator?.startAnimation()
        
        propertyAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 2, animations: {
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 100
        scaleAnimation.mass = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.beginTime = CACurrentMediaTime() + 1
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.animations = [opacity, scaleAnimation]
            self.passLabel.layer.add(animationGroup, forKey: nil)
        })
    }
    
    
}

extension ViewController{
    func Cloud(){
        let cloud = UIView()
        view.addSubview(cloud)
        cloud.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cloud.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cloud.bottomAnchor.constraint(equalTo: animateView.bottomAnchor, constant: -10),
            cloud.widthAnchor.constraint(equalToConstant: 120),
            cloud.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 60))
        
        path.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 50))
        path.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
        path.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
        path.addQuadCurve(to: CGPoint(x: 80, y: 30), controlPoint: CGPoint(x: 80, y: 20))
        path.addQuadCurve(to: CGPoint(x: 110, y: 60), controlPoint: CGPoint(x: 110, y: 30))
        
 //       path.addQuadCurve(to: CGPoint(x: 50, y: 60), controlPoint: CGPoint(x: 40, y: 40))
        path.close()
        
        let layerAnimation = CAShapeLayer()
        layerAnimation.path = path.cgPath
        layerAnimation.strokeColor = UIColor.link.cgColor
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 6
        layerAnimation.lineCap = .round
        
        cloud.layer.addSublayer(layerAnimation)
        
        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimationEnd.fromValue = 0
        pathAnimationEnd.toValue = 1
        pathAnimationEnd.duration = 2
        pathAnimationEnd.isRemovedOnCompletion = false
        pathAnimationEnd.fillMode = .both

        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        pathAnimationStart.fromValue = 0
        pathAnimationStart.toValue = 1
        pathAnimationStart.duration = 2
        pathAnimationStart.isRemovedOnCompletion = false
        pathAnimationStart.fillMode = .both
        pathAnimationStart.beginTime = 1


        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)
    }
}


//private extension ViewController{
//    func runAnimate(){
//        UIView.animate(withDuration: 1){
//            self.gradiend.startPoint = CGPoint(x: 0.5, y: 0)
//            self.gradiend.endPoint = CGPoint(x: 0.5, y: 1)
//            self.gradiend.startColor = .purple
//            self.gradiend.endColor = .red
//        } completion: { _ in
//            self.revertAnimate()
//        }
//    }
//
//    func revertAnimate(){
//        UIView.animate(withDuration: 1, delay: 1, options: [.repeat, .autoreverse, .transitionCurlUp], animations: {
//            self.gradiend.startPoint = CGPoint(x: 0.5, y: 0)
//            self.gradiend.endPoint = CGPoint(x: 0.5, y: 1)
//            self.gradiend.endColor = .systemGreen
//            self.gradiend.startColor = .link
//        }, completion: nil)
//    }
//
//
//}
