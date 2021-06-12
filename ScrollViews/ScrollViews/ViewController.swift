//
//  ViewController.swift
//  ScrollViews
//
//  Created by KPUGAME on 2021/03/29.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "photo1.png")!
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x:0,y:0), size: image.size)
        scrollView.addSubview(imageView)
        
        scrollView.contentSize = image.size
        
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.scrollViewDoubleTapped(_ :)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
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
        var contensFrame = imageView.frame
        
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
        imageView.frame = contensFrame
    }
    
    @objc func scrollViewDoubleTapped(_ recognizer: UITapGestureRecognizer) {
        let pointInView = recognizer.location(in: imageView)
        
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
        
        scrollView.zoom(to: rectToZoomTo, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
}

