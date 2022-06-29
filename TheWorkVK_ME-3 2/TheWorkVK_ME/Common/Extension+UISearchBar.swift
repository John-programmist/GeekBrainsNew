//
//  Extension+UISearchBar.swift
//  TheWorkVK_ME
//
//  Created by Олег Ганяхин on 04.02.2022.
//

import UIKit

extension UISearchBar {
	public var textField: UITextField? {
		if #available(iOS 13, *) {
			return searchTextField
		}
		let subViews = subviews.flatMap {$0.subviews}
		guard let textField = (subViews.filter {$0 is UITextField }).first as? UITextField else {
			return nil
		}
		return textField
	}

	func clearBackgraundColor() {
		guard let UISearchBarBackgraund: AnyClass = NSClassFromString("UISearchBarBackgraund") else {return}

		for view in subviews {
			for subview in view.subviews where subview.isKind(of: UISearchBarBackgraund) {
				subview.alpha = 0
			}
		}
	}

	func changePlaceholderColor(_ color: UIColor) {
		guard let UISearchBarTextFieldLable: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
			  let field = textField else {
				  return
			  }
		for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLable) {
			(subview as! UILabel).textColor = color
		}
	}

	func setRightImage(normalImage: UIImage,
					   highLightedImage: UIImage) {
		showsBookmarkButton = true
		if let btn = textField?.rightView as? UIButton {
			btn.setImage(normalImage,
						 for: .normal)
			btn.setImage(highLightedImage,
						 for: .highlighted)
		}
	}

	func setLeftImage(_ image: UIImage,
					  with padding: CGFloat = 0,
					  tintColor: UIColor) {
		let imageView = UIImageView()
		imageView.image = image
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
		imageView.tintColor = tintColor

		if padding != 0 {
			let stackView = UIStackView()
			stackView.axis = .horizontal
			stackView.alignment = .center
			stackView.distribution = .fill
			stackView.translatesAutoresizingMaskIntoConstraints = false

			let paddingView = UIView()
			paddingView.translatesAutoresizingMaskIntoConstraints = false
			paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
			paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
			stackView.addArrangedSubview(paddingView)
			stackView.addArrangedSubview(imageView)
			textField?.leftView = stackView

		} else {
			textField?.leftView = imageView
		}
	}
}
