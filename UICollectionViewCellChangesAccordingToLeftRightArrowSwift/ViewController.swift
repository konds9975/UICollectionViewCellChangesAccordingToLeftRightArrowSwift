//
//  ViewController.swift
//  UICollectionViewCellChangesAccordingToLeftRightArrowSwift
//
//  Created by Hitendra Bhoir on 16/06/18.
//  Copyright © 2018 Hitendra Bhoir. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
   

    var currentPageNumber : Int?
    
    @IBOutlet weak var animalCollectionView: UICollectionView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.animalCollectionView.delegate = self
        self.animalCollectionView.dataSource = self
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.animalCollectionView.frame.size.width, height: self.animalCollectionView.frame.size.height)
        self.animalCollectionView.isPagingEnabled = true
        self.animalCollectionView!.collectionViewLayout = layout
         self.leftBtn.isHidden = true
       
    }

    
    @IBAction func leftBtnClick(_ sender: Any)
    {
        let visibleItems: NSArray = self.animalCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.item == 0
        {
            self.leftBtn.isHidden = true
            self.rightBtn.isHidden = false
        }
        else
        {
            self.leftBtn.isHidden = false
            self.rightBtn.isHidden = false
        }
       if nextItem.row < 9 && nextItem.row >= 0
        {
           
           self.animalCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
           
        }
        
    }
    
    @IBAction func rightBtnClick(_ sender: Any)
    {
        let visibleItems: NSArray = self.animalCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
       
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        
        if nextItem.item == 8
        {
            self.leftBtn.isHidden = false
            self.rightBtn.isHidden = true
        }
        else
        {
            self.leftBtn.isHidden = false
            self.rightBtn.isHidden = false
        }
    
            
        if nextItem.row < 9
        {
          
            self.animalCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
           
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.animalCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        let y = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/y))
        if currentPage == 0
        {
            self.leftBtn.isHidden = true
            self.rightBtn.isHidden = false
        }
        else if currentPage == 8
        {
            self.leftBtn.isHidden = false
            self.rightBtn.isHidden = true
        }
        else
        {
            self.leftBtn.isHidden = false
            self.rightBtn.isHidden = false
        }
        
    }
    
    
    
}

