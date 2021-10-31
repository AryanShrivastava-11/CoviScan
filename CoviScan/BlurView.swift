//
//  BlurView.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 30/10/21.
//
import SwiftUI

struct BlurView: UIViewRepresentable{
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style) //sysMaterial is used as it adapts in dark mode automatically
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}
