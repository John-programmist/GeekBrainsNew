
import UIKit

@IBDesignable
class LikeProcess: UIControl {
    
    var likeButton: Bool = false{
        didSet{
            if likeButton{
                buttonMain.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                buttonMain.tintColor = .red
                runAnimate()
            }else{
                revertAnimate()
                buttonMain.tintColor = .blue
                buttonMain.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            }
        }
    }
    var buttonMain: UIButton!
    private var stackView: UIStackView!
    var amountL: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    
    private func setup(){
        let button = UIButton(type: .system)
        let amountOfLikes = UILabel()
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        amountOfLikes.text = "0"
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonMain = button
        amountL = amountOfLikes
        
        stackView = UIStackView(arrangedSubviews: [buttonMain, amountL])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        sendActions(for: .valueChanged)
    }
    
    func runAnimate(){
        UIView.transition(with: amountL, duration: 1, options: [.transitionCrossDissolve], animations: {self.amountL.text = "1"})
    }
    
    func revertAnimate(){
        UIView.transition(with: amountL, duration: 1, options: [.transitionCrossDissolve], animations: {self.amountL.text = "0"})
    }
    
}

