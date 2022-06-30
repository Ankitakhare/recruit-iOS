//
//  Extensions.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.


import Foundation

import UIKit

public extension UIView {
    
     class func initFromNib<T: UIView>() -> T {
        
        let bundle = Bundle(for: T.self)
        return bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
     func width(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
     func height(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
     func pinLeft(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        leftAnchor.constraint(equalTo: superView.leftAnchor, constant: constant).isActive = true
    }
    
     func pinRight(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        rightAnchor.constraint(equalTo: superView.rightAnchor, constant: constant).isActive = true
    }
    
     func pinTop(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
    }
    
     func pinBottom(_ constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant).isActive = true
    }
    
     func centerX() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
       centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
    }
    
    func centerY(_ centerYSpace: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {
            return
        }
        
        centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: centerYSpace).isActive = true
    }
    
     func fillSuperview(padding: UIEdgeInsets) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
     func fillSuperview() {
        fillSuperview(padding: .zero)
    }
    
     func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
     func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}


