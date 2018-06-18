//
//  TableFilterVC.swift
//  UICollectionViewCellChangesAccordingToLeftRightArrowSwift
//
//  Created by Hitendra Bhoir on 16/06/18.
//  Copyright © 2018 Hitendra Bhoir. All rights reserved.
//

import UIKit

struct SectionInfo {
    
    var headerTitle : String?
    var rowArray : [SectionRowInfo]?
    var isExpand : Bool

}

struct SectionRowInfo {
    
    var name : String?
    var isCheck : Bool
}




class TableFilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var filterTableView: UITableView!
    
    var filterArray = [SectionInfo]()
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        filterArray.append(SectionInfo.init(headerTitle: "Mobile", rowArray:[SectionRowInfo.init(name: "Apple", isCheck: false),SectionRowInfo.init(name: "Nokia", isCheck: false),SectionRowInfo.init(name: "Samsung", isCheck: false)], isExpand: false))
        
        filterArray.append(SectionInfo.init(headerTitle: "TV", rowArray:[SectionRowInfo.init(name: "Apple", isCheck: false),SectionRowInfo.init(name: "Onida", isCheck: false),SectionRowInfo.init(name: "Samsung", isCheck: false)], isExpand: false))
        
        filterArray.append(SectionInfo.init(headerTitle: "Latop", rowArray:[SectionRowInfo.init(name: "Apple", isCheck: false),SectionRowInfo.init(name: "LG", isCheck: false),SectionRowInfo.init(name: "Samsung", isCheck: false)], isExpand: false))
       
       
        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self

    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        
       return filterArray.count
        
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let isExpand = filterArray[section].isExpand
        if isExpand
        {
             return filterArray.count
        }
        else
        {
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell =  self.filterTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.rowLabel.text = filterArray[indexPath.section].rowArray![indexPath.row].name
        
        var isCheck = filterArray[indexPath.section].rowArray![indexPath.row].isCheck
        
        if (isCheck)
        {
            cell.imgView.image = UIImage(named: "check_box_2-1")
            isCheck = false
        }
        else
        {
            cell.imgView.image = UIImage(named: "Terms-and-Conditions-2")
            isCheck = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let cell =  self.filterTableView.dequeueReusableCell(withIdentifier: "TableViewCellH") as! TableViewCell
        cell.headerLabel.text = filterArray[section].headerTitle
        cell.headerBtn.tag = section
        cell.headerBtn.addTarget(self, action: #selector(headerBtnlick), for: .touchUpInside)
        return cell.contentView
        
    }
    
    @objc func headerBtnlick(sender:UIButton)
    {
        var isExpand = filterArray[sender.tag].isExpand
        if isExpand
        {
            isExpand = false
            filterArray[sender.tag].isExpand = isExpand
        }
        else
        {
            isExpand = true
            filterArray[sender.tag].isExpand = isExpand
        }
       filterTableView.reloadSections(IndexSet(integer: sender.tag), with: .left) // You can change animation from here .none,.automatic,.left etc
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let cell =  self.filterTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        var isCheck = filterArray[indexPath.section].rowArray![indexPath.row].isCheck
        
        if isCheck
        {
            isCheck = false
            filterArray[indexPath.section].rowArray![indexPath.row].isCheck = isCheck
            cell.imgView.image = UIImage(named: "Terms-and-Conditions-2")
        }
        else
        {
            isCheck = true
            filterArray[indexPath.section].rowArray![indexPath.row].isCheck = isCheck
            cell.imgView.image = UIImage(named: "check_box_2-1")
        }
        
        filterTableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    
}
