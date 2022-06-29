//
//  CaruselkaViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 10.01.2022.
//

import UIKit

final class CaruselkaViewController: UIViewController {
    
    var photos: [UIImage] = []
    var photoViews: [UIImageView] = []

    var selectedPhoto = 0

    private var leftImageView: UIImageView!
    private var middleImageView: UIImageView!
    private var rightImageView: UIImageView!

    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!

    func createImageViews() {
        for photo in photos {
            let view = UIImageView()
            view.image = photo
            view.contentMode = .scaleAspectFit

            photoViews.append(view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        createImageViews()
        leftImageView = UIImageView()
        middleImageView = UIImageView()
        rightImageView = UIImageView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(gestPan)



        setImage()
        startAnimate()
    }

   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.subviews.forEach({ $0.removeFromSuperview() }) // проходится по всем сабвью этой вьюхи и удаляет её из родителя
    }

    func setImage(){
        var indexPhotoLeft = selectedPhoto - 1
        let indexPhotoMid = selectedPhoto
        var indexPhotoRight = selectedPhoto + 1

        if indexPhotoLeft < 0 {
            indexPhotoLeft = photoViews.count - 1

        }
        if indexPhotoRight > photoViews.count - 1 {
            indexPhotoRight = 0
        }

        view.subviews.forEach({ $0.removeFromSuperview() })

        leftImageView = photoViews[indexPhotoLeft]
        middleImageView = photoViews[indexPhotoMid]
        rightImageView = photoViews[indexPhotoRight]

        view.addSubview(leftImageView)
        view.addSubview(middleImageView)
        view.addSubview(rightImageView)

        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 1),
            middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

            rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
        ])

        middleImageView.layer.cornerRadius = 8
        rightImageView.layer.cornerRadius = 8
        leftImageView.layer.cornerRadius = 8

        middleImageView.clipsToBounds = true
        rightImageView.clipsToBounds = true
        leftImageView.clipsToBounds = true

        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)

        self.middleImageView.transform = scale
        self.rightImageView.transform = scale
        self.leftImageView.transform = scale

    }

    func startAnimate() {
        setImage()
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [],
                       animations: { [unowned self] in
            self.middleImageView.transform = .identity
            self.leftImageView.transform = .identity
            self.rightImageView.transform = .identity
        })
    }

    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(duration: 1,
                                                  curve: .easeInOut,
                                                  animations: {
                UIView.animate(withDuration: 0.01,
                               delay: 0,
                               options: [],
                               animations: { [unowned self] in
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 40, y: 0)
                    let transform = scale.concatenating(translation)
                    middleImageView.transform = transform
                    leftImageView.transform = transform
                    rightImageView.transform = transform
                },
                               completion: { [unowned self] _ in
                    self.selectedPhoto -= 1
                    if self.selectedPhoto < 0 {
                        self.selectedPhoto = self.photos.count - 1
                    }
                    self.startAnimate()
                })
            })
            swipeToLeft = UIViewPropertyAnimator(duration: 1,
                                                 curve: .easeInOut,
                                                 animations: {
                UIView.animate(withDuration: 0.01,
                               delay: 0,
                               options: [],
                               animations: { [unowned self] in
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 40, y: 0)
                    let transform = scale.concatenating(translation)
                    middleImageView.transform = transform
                    leftImageView.transform = transform
                    rightImageView.transform = transform
                },
                               completion: { [unowned self] _ in
                    self.selectedPhoto += 1
                    if self.selectedPhoto > self.photos.count - 1 {
                        self.selectedPhoto = 0
                    }
                    self.startAnimate()
                })
            })
        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX)/100
            } else {
                swipeToLeft.fractionComplete = abs(translationX)/100
            }
        case .ended:
            swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }
}

