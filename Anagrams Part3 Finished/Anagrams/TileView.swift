//
//  TileView.swift
//  Anagrams
//
//  Created by KIMYOUNG SIK on 2018. 2. 10..
//  Copyright © 2018년 Caroline. All rights reserved.
//
//Anagrams Part3
//Enhanced Tile Dragging
//tile을 옮길 때 좀 더 사실적으로 보이게 하기 위해서
//들어올리는 것 처럼 약간 크기를 키우고 그림자를 표현한다.

import UIKit
//2D Graphics Framework
import QuartzCore

protocol TileDragDelegateProtocol {
    func tileView(tileView: TileView, didDragToPoint: CGPoint)
}

//백그라운드 이미지를 가지는 tile을 생성한 후 나중에 letter를 추가함
//1. TileView 클래스가 UIImageView 를 상속하므로 나중에 UILabel과 추가하면 됨
class TileView: UIImageView {
    //손가락으로 tile을 터치할 때 tile의 center에서 x, y offset
    private var xOffset: CGFloat = 0.0
    private var yOffset: CGFloat = 0.0
    
    var dragDelegate: TileDragDelegateProtocol?
    
    //tile resizing을 위한 변수
    var tempTransform: CGAffineTransform = CGAffineTransform.identity

    //2. letter 변수
    var letter: Character
    //3. match true/false 변수
    var isMatched: Bool = false
    //4. 이 코드는 호출되면 안됨
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    //5. 주어진 letter 에 대한 새로운 타일 생성
    init(letter: Character, sideLength: CGFloat) {
        self.letter = letter
        //tile.png 를 백그라운드 이미지로 로딩
        let image = UIImage(named: "tile")!
        
        super.init(image: image)
        //anagram이 길수 있으니까 스크린 크기에 맞도록 scale
        //TileView의 frame 을 자동으로 resize
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
        
        // init() 메소드 끝에 글자 label을 타일에 추가
        let letterLabel = UILabel(frame: self.bounds)
        letterLabel.textAlignment = NSTextAlignment.center
        letterLabel.textColor = UIColor.white
        letterLabel.backgroundColor = UIColor.clear
        letterLabel.text = String(letter).uppercased()
        letterLabel.font = UIFont(name: "Verdana-Bold", size: 78 * scale)
        self.addSubview(letterLabel)
        //iOS가 tileView의 touch event를 전달하도록 해준다.
        self.isUserInteractionEnabled = true
        //init() 내부에 그림자 생성
        //UIView는 자체 layer를 가짐
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0    //현재 그림자는 안보이게 설정, 나중에 움직이면 보이게 바꿈
        self.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false //원래 Bounds 바깥은 rendering 안되는데 false로 바꿈
        
        let path = UIBezierPath(rect: self.bounds) //그림자 path
        self.layer.shadowPath = path.cgPath
    }
    //게임 보드에서 anagram 글자를 slightly random하게 회전하면 좀더 자연스럽게 보인다.
    func randomize() {
        //-0.2~0.3 라디안 랜덤 생성
        let rotation = CGFloat(randomNumber(minX: 0, maxX: 50)) / 100 - 0.2
        //회전
        self.transform = CGAffineTransform(rotationAngle: rotation)
        //upwards 방향 -10~0 랜덤 생성
        let yOffset = CGFloat(randomNumber(minX: 0, maxX: 10) - 10)
        self.center = CGPoint(x: self.center.x , y: self.center.y + yOffset)
    }
    
    //title dragging 메소드들
    //1. 터치가 감지되면 tile안의 터치 위치를 얻어서 xOffset/yOffset 계산
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self.superview)
            xOffset = touchPoint.x - self.center.x
            yOffset = touchPoint.y - self.center.y
        }
        //그림자 보이게 설정
        self.layer.shadowOpacity = 0.8
        //tile resizing을 위해서 기존 변환을 저장
        tempTransform = self.transform
        //tile 1.2 scaling 변환
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        //원래 superview는 subview가 add 된 순서대로 display한다.
        //tile 이 다른 tile의 밑으로 가는 것을 막는다.
        self.superview?.bringSubviewToFront(self)
    }
    //2. 터치를 움직이면 tile 위치를 움직인다. xOffset/yOffset을 반영해서 center 를 옮김
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self.superview)
            self.center = CGPoint(x: touchPoint.x - xOffset, y: touchPoint.y - yOffset)
        }
    }
    //3. 손가락을 떼면 마직막으로 touchesMoved() 호출한다.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMoved(touches, with: event)
        //drageDelegate의 tileView 메소드를 호출해서 tile(self)과 self.center 를 전달
        self.dragDelegate?.tileView(tileView: self, didDragToPoint: self.center)
        //그림자 안보이게 설정
        self.layer.shadowOpacity = 0
        //tile resizing을 원래대로 되돌림
        self.transform = tempTransform
     }
    //low memory상황 등을 위한 touchCancelled 메소드 추가 : 변환을 이전 것으로 되돌림
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = tempTransform
        self.layer.shadowOpacity = 0
    }
}
