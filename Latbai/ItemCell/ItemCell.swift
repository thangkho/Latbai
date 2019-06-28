//
//  ItemCell.swift
//  Latbai
//
//  Created by user1 on 6/27/19.
//  Copyright © 2019 hoatv. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var imgHide: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgHide.image = UIImage(named: "block")
        self.imgShow.isHidden = true
        

    }
    func setData(_ text : thebai){
        if(text.isClose){
            UIView.transition(with: self.imgHide, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.imgHide.isHidden = true
            }, completion: nil)
        }else if(text.isOpen){
            self.imgHide.isHidden = false
            self.imgHide.image = UIImage(named: text.name)
        }else{
            self.imgHide.isHidden = false
            self.imgHide.image = UIImage(named: "block")
        }


    }
    
    func showImage(isShow: Bool!,text: String){
        if isShow{
            self.imgHide.image = UIImage(named: text)

            //            UIView.transition(with: self.imgHide, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            //            UIView.transition(from: self.imgHide, to: self.imgShow,
            //                              duration: 0.3, options: [.transitionFlipFromRight,
            //                                                       .showHideTransitionViews]) { _ in
            //                                                        self.imgHide.isHidden = true
            //                                                        self.imgShow.isHidden = false}

        }else{
            self.imgHide.image = UIImage(named: "block")

            //            UIView.transition(from: self.imgShow, to: self.imgHide,
            //                              duration: 0.3, options: [.transitionFlipFromRight,
            //                                                       .showHideTransitionViews]) { _ in
            //                                                        self.imgHide.isHidden = false
            //                                                        self.imgShow.isHidden = true}
        }
        UIView.transition(with: self.imgHide, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }

    func hideImage(){
        UIView.transition(with: self.imgHide, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.imgHide.isHidden = true
        }, completion: nil)
    }
}
