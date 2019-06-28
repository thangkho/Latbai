//
//  ViewController.swift
//  Latbai
//
//  Created by user1 on 6/27/19.
//  Copyright © 2019 hoatv. All rights reserved.
//

import UIKit
class thebai{
    var name : String!
    var isOpen: Bool! = false
    var isClose: Bool! = false
    
    init(name: String) {
        self.name = name
    }
}

class ViewController: UIViewController {
    var firstPosition : IndexPath!
    var firstCard : String = ""
    var secondCard : String = ""
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func reloadGame(_ sender: Any) {
        self.playAgain()
        self.startTimer()
    }

    //    @IBAction func playAgain(_ sender: Any) {
    //        self.playAgain()
    //        self.startTimer()
    //    }
    var dataArray = ["anh1.png","anh2.png","anh3.png","anh4.png","anh5.png","anh6.png","anh7.png","anh8.png","anh1.png","anh2.png","anh3.png","anh4.png","anh5.png","anh6.png","anh7.png","anh8.png"]
    
    var listThebai: [thebai] = []
    
    var TIMER = Timer()
    var COUNT = 60
    @objc func timeDown(){
        COUNT = COUNT - 1
        labelTime.text = String(COUNT)
        if(COUNT==0){
            TIMER.invalidate()
            if !self.checkWin(){
                self.alertTryAgain(tilte: "", content: "Do you want try again?")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        dataArray.forEach { (name) in
        //            listThebai.append(thebai(name: name))
        //        }
        
        listThebai = dataArray.map({ thebai(name: $0) })
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        self.listThebai.shuffle()
        startTimer()
    }
    func startTimer(){
        if    TIMER.isValid{
            TIMER.invalidate()
        }
        COUNT = 60;
        self.labelTime.text = String(COUNT)
        TIMER = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timeDown), userInfo: nil, repeats: true)
    }
    func alertTryAgain(tilte: String, content:String){
        let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            self.playAgain()
            self.startTimer()
        }))
        self.present(alert, animated: true)
    }
    
    func alertWin(tilte: String, content:String){
        let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listThebai.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)  as! ItemCell
        cell.setData(self.listThebai[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(String(firstCard.isEmpty) + " " + String(secondCard.isEmpty))
        if self.listThebai[indexPath.row].isClose || !firstCard.isEmpty && !secondCard.isEmpty || indexPath == firstPosition{
            return
        }
        let cell = self.collectionView.cellForItem(at: indexPath) as! ItemCell
        self.listThebai[indexPath.row].isOpen = !self.listThebai[indexPath.row].isOpen
        cell.showImage(isShow: self.listThebai[indexPath.row].isOpen,text: self.listThebai[indexPath.row].name)
        if(firstCard.isEmpty){
            firstPosition = indexPath
            firstCard = self.listThebai[indexPath.row].name
        }else if(secondCard.isEmpty){
            secondCard = self.listThebai[indexPath.row].name
            if(secondCard == firstCard){
                self.listThebai[indexPath.row].isClose = true
                self.listThebai[firstPosition.row].isClose = true
            }else{
                self.listThebai[indexPath.row].isOpen = !self.listThebai[indexPath.row].isOpen
                self.listThebai[firstPosition.row].isOpen = !self.listThebai[firstPosition.row].isOpen
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.collectionView.reloadItems(at: [self.firstPosition, indexPath])
                self.firstPosition = nil
                self.firstCard = ""
                self.secondCard = ""
                if self.checkWin(){
                    self.TIMER.invalidate()
                    self.alertWin(tilte: "Finished", content: "You Win");
                }
            }
            
        }
    }
    func checkWin() -> Bool {
        for a in listThebai {
            if !a.isClose{
                return false
            }
        }
        return true
    }
    func playAgain(){
        for a in listThebai {
            a.isOpen = false
            a.isClose = false
        }
        self.listThebai.shuffle()
        self.collectionView.reloadData()
    }
    
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-15)/4,height: (collectionView.frame.height-40)/4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom:5, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

