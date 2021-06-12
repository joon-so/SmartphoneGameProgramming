//
//  CustomScrollViewController.swift
//  ScrollViews
//
//  Created by KPUGAME on 2021/03/30.
//

import UIKit

class CustomScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        let containerSize = CGSize(width: 640.0, height: 640.0)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize))
        scrollView.addSubview(containerView)
        
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 80))
        redView.backgroundColor = UIColor.red
        containerView.addSubview(redView)
        
        let blueView = UIView(frame: CGRect(x: 0, y: 560, width: 640, height: 80))
        blueView.backgroundColor = UIColor.blue
        containerView.addSubview(blueView)
        
        let greenView = UIView(frame: CGRect(x: 160, y: 160, width: 320, height: 320))
        greenView.backgroundColor = UIColor.green
        containerView.addSubview(greenView)
        
        let imageView = UIImageView(image: UIImage(named: "slow.png"))
        imageView.center = CGPoint(x: 320, y: 320)
        containerView.addSubview(imageView)
        
        scrollView.contentSize = containerSize
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = minScale
        
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale
        
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contensFrame = containerView.frame
        
        if contensFrame.size.width < boundsSize.height {
            contensFrame.origin.x = (boundsSize.width - contensFrame.size.width) / 2.0
        } else {
            contensFrame.origin.x = 0.0
        }
        if contensFrame.size.height < boundsSize.height {
            contensFrame.origin.y = (boundsSize.height - contensFrame.size.height) / 2.0
        } else {
            contensFrame.origin.y = 0.0
        }
        containerView.frame = contensFrame
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
}
