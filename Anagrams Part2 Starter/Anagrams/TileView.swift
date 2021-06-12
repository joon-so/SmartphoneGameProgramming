//
//  TileView.swift
//  Anagrams
//
//  Created by KIMYOUNG SIK on 2018. 2. 10..
//  Copyright © 2018년 Caroline. All rights reserved.
//
import UIKit
//백그라운드 이미지를 가지는 tile을 생성한 후 나중에 letter를 추가함
//1. TileView 클래스가 UIImageView 를 상속하므로 나중에 UILabel과 추가하면 됨
class TileView: UIImageView {
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
}
