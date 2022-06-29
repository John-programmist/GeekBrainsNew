//
//  PostNews.swift
//  TheWorkVK_ME
//
//  Created by Roman on 29.12.2021.


import UIKit

@IBDesignable
class PostNews: UIControl {
    
    let random: String = String(Int.random(in: 1..<10))

    var Buttons: [Bool] = [false, false, false]{
        didSet{
            if Buttons[0]{
                if Buttons[1]{
                    if Buttons[2]{
                        likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                        amountOfLikes.text = "1"
                        //
                        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                        amountOfComments.text = "1"
                        //
                        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle.fill"), for: .normal)
                        //
                        prosmotr.image = UIImage(systemName: "eye")
                        amountOfProsmotr.text = random
                    }
                    else{
                        likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                        amountOfLikes.text = "1"
                        //
                        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                        amountOfComments.text = "1"
                        //
                        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle"), for: .normal)
                        //
                        prosmotr.image = UIImage(systemName: "eye")
                        amountOfProsmotr.text = random
                    }
                }
                else{
                if Buttons[2]{
                    likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                    amountOfLikes.text = "1"
                    //
                    comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                    amountOfComments.text = "0"
                    //
                    mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle.fill"), for: .normal)
                    //
                    prosmotr.image = UIImage(systemName: "eye")
                    amountOfProsmotr.text = random
                }
                else{
                    likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                    amountOfLikes.text = "1"
                    //
                    comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                    amountOfComments.text = "0"
                    //
                    mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle"), for: .normal)
                    //
                    prosmotr.image = UIImage(systemName: "eye")
                    amountOfProsmotr.text = random
                }
            }
        }
            else{
                if Buttons[1]{
                    if Buttons[2]{
                        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                        amountOfLikes.text = "0"
                        //
                        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                        amountOfComments.text = "1"
                        //
                        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle.fill"), for: .normal)
                        //
                        prosmotr.image = UIImage(systemName: "eye")
                        amountOfProsmotr.text = random
                    }
                    else{
                        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                        amountOfLikes.text = "0"
                        //
                        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                        amountOfComments.text = "1"
                        //
                        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle"), for: .normal)
                        //
                        prosmotr.image = UIImage(systemName: "eye")
                        amountOfProsmotr.text = random
                    }
                }
                else{
                    if Buttons[2]{
                        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                        amountOfLikes.text = "0"
                        //
                        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                        amountOfComments.text = "0"
                        //
                        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle.fill"), for: .normal)
                        //
                        prosmotr.image = UIImage(systemName: "eye")
                        amountOfProsmotr.text = random
                    }
                    else{
                        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                        amountOfLikes.text = "0"
                        //
                        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
                        amountOfComments.text = "0"
                        //
                        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle"), for: .normal)
                        //
                        prosmotr.image = UIImage(systemName: "eye")
                        amountOfProsmotr.text = random
                    }
                }
            }
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private var stackView: UIStackView!

    var likeButton: UIButton! = UIButton(type: .system)
    var amountOfLikes: UILabel! = UILabel()
    var gradiendLike = GradientView()
    
    

    var comment: UIButton! = UIButton(type: .system)
    var amountOfComments: UILabel! = UILabel()
    var gradiendComment =  GradientView()


    var mail: UIButton! = UIButton(type: .system)
    var gradiendMail = GradientView()


    var prosmotr: UIImageView! = UIImageView()
    var amountOfProsmotr: UILabel! = UILabel()
    var gradiendProsmotr = GradientView()



    private func setup(){
        
        
        gradiendLike.startColor = .red
        gradiendLike.endColor = .blue
        gradiendLike.startPoint = CGPoint(x: 0, y: 0)
        gradiendLike.endPoint = CGPoint(x: 1, y: 1)
        gradiendLike.layer.cornerRadius = 10
        //gradiendLike.layer.frame = CGRect(x: 1, y: 1, width: 20, height: 20)
        
        
        gradiendComment.startColor = .systemBlue
        gradiendComment.endColor = .systemGreen
        gradiendComment.startPoint = CGPoint(x: 0, y: 0)
        gradiendComment.endPoint = CGPoint(x: 1, y: 1)
        //gradiendComment.layer.frame = CGRect(x: 100, y: 1, width: 20, height: 20)
        
        gradiendMail.startColor = .brown
        gradiendMail.endColor = .green
        gradiendMail.startPoint = CGPoint(x: 0, y: 0)
        gradiendMail.endPoint = CGPoint(x: 1, y: 1)
        //
        
        gradiendProsmotr.startColor = .purple
        gradiendProsmotr.endColor = .green
        gradiendProsmotr.startPoint = CGPoint(x: 0, y: 0)
        gradiendProsmotr.endPoint = CGPoint(x: 1, y: 1)
    
        
        
        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        amountOfLikes.text = "0"
        
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        likeButton.frame = CGRect(x: 0, y: 38/4, width: 20, height: 20)
        amountOfLikes.frame = CGRect(x: 20, y: 38/4, width: 20, height: 20)
        
        
        gradiendLike.addSubview(likeButton)
        gradiendLike.addSubview(amountOfLikes)
        
        //---------
        comment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        amountOfComments.text = "0"
        
        comment.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        
        comment.frame = CGRect(x: 0, y: 38/4, width: 20, height: 20)
        amountOfComments.frame = CGRect(x: 20, y: 38/4, width: 20, height: 20)
        
        gradiendComment.addSubview(comment)
        gradiendComment.addSubview(amountOfComments)
        //----------
        mail.setImage(UIImage(systemName: "arrowshape.turn.up.right.circle"), for: .normal)
        
        mail.addTarget(self, action: #selector(mailTapped), for: .touchUpInside)
        
        mail.frame = CGRect(x: 0, y: 38/4, width: 20, height: 20)
        
        gradiendMail.addSubview(mail)
        //----------
        prosmotr.image = UIImage(systemName: "eye")
        amountOfProsmotr.text = random
        
        prosmotr.frame = CGRect(x: 0, y: 38/4, width: 40, height: 20)
        amountOfProsmotr.frame = CGRect(x: 40, y: 38/4, width: 20, height: 20)
        
        gradiendProsmotr.addSubview(prosmotr)
        gradiendProsmotr.addSubview(amountOfProsmotr)
        
        //stackView = UIStackView(arrangedSubviews: [buttonMain, amountOfLikes, comment, amountOfComments, mail, prosmotr, amountOfProsmotr])
        stackView = UIStackView(arrangedSubviews: [gradiendLike, gradiendComment, gradiendMail, gradiendProsmotr])
        stackView.spacing = 8
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 38),
            stackView.widthAnchor.constraint(equalToConstant: 280),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    @objc private func likeTapped(_ sender: UIButton){
        sendActions(for: .valueChanged)
    }
    
    @objc private func commentTapped(_ sender: UIButton){
        sendActions(for: .valueChanged)
    }
    
    @objc private func mailTapped(_ sender: UIButton){
        sendActions(for: .valueChanged)
    }

}
