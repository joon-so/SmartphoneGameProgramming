//
//  PeekPagedScrollViewController.swift
//  ScrollViews
//
//  Created by KPUGAME on 2021/04/04.
//

import UIKit

class PeekPagedScrollViewController: UIViewController , UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    //1페이지마다 1개 이미지를 갖는 UIImage 배열
    var pageImages: [UIImage] = []
    //UIImageView 배열로써 optional임, 왜나하면 필요할 때 로딩하므로!!
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageImages = [UIImage(named: "photo1.png")!,
                      UIImage(named: "photo2.png")!,
                      UIImage(named: "photo3.png")!,
                      UIImage(named: "photo4.png")!,
                      UIImage(named: "photo5.png")!]
        let pageCount = pageImages.count
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: pagesScrollViewSize.height)
        
        loadVisiblePages()
    }
    func loadPage(_ page: Int) {
        if page < 0 || page >= pageImages.count {
            return
        }
        
        if pageViews[page] != nil {
            //아무일도 안함
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            frame = frame.insetBy(dx: 10.0, dy: 0.0)
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .scaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(_ page: Int) {
        if page < 0 || page >= pageImages.count {
            return
        }
        
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadVisiblePages() {
        let pageWidth = scrollView.frame.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        for index in 0 ..< firstPage+1 {
            purgePage(index)
        }
        
        for index in firstPage ... lastPage {
            loadPage(index)
        }
        
        for index in lastPage+1 ..< pageImages.count+1 {
            purgePage(index)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadVisiblePages()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
