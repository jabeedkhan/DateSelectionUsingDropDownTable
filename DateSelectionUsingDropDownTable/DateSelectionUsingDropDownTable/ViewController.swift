//
//  ViewController.swift
//  DateSelectionUsingDropDownTable
//
//  Created by jabeed on 04/09/19.
//  Copyright © 2019 jabeed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnDrop: UIButton!
    var dayList = ["Today","Yesterday","Last 7 Days","Last 30 Days","This Month","Last Month"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tblView.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickButton(_ sender: Any) {
        if tblView.isHidden{
            animate(toogle: true)
        }else {
            animate(toogle: false)
        }
        
    }
    
    func animate(toogle:Bool) {
        if toogle {
            UIView.animate(withDuration: 0.3) {
            self.tblView.isHidden = false
            }
        }else {
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = true
            }
            
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dayList[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentString = dayList[indexPath.row]
        print(currentString)
        btnDrop.setTitle("\(dayList[indexPath.row])", for: .normal)
        animate(toogle: false)
        
        switch currentString {
        case "Today":
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM dd"
            let result = formatter.string(from: currentDate)
            //            selectOutlet.titleLabel?.text =  result + " - " + result
            btnDrop.setTitle(result + " - " + result, for: .normal)
            print("today is selecte")
            break
        case "Yesterday":
            let currentDate = Date()
            let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yy"
            let result = formatter.string(from: yesterdayDate)
            btnDrop.setTitle(result + " - " + result, for: .normal)
            print("Yesterday is selected")
            break
        case "Last 7 Days":
            let currentDate = Date()
            let lastSevenDaysDate = Calendar.current.date(byAdding: .day, value: -6, to: currentDate)!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yy"
            let result = formatter.string(from: lastSevenDaysDate)
            let currentDateResult = formatter.string(from: currentDate)
            btnDrop.setTitle(result + " - " + currentDateResult, for: .normal)
            print("Last 7 days is selected")
            break
            
        case "Last 30 Days":
            print("Last 30 days is selected")
            let currentDate = Date()
            let lastThirtyDaysDate = Calendar.current.date(byAdding: .day, value: -29, to: currentDate)!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yy"
            let result = formatter.string(from: lastThirtyDaysDate)
            let currentDateResult = formatter.string(from: currentDate)
            btnDrop.setTitle(result + " - " + currentDateResult, for: .normal)
            print("Last 30 Days")
            break
            
        case "This Month":
            let dateFormatter = DateFormatter()
            let currentDate = Date()
            dateFormatter.dateFormat = "dd MMM yy"
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: currentDate)
            let startOfMonth = Calendar.current.date(from: comp)!
            let startDateString = dateFormatter.string(from: startOfMonth)
            
            var comps2 = DateComponents()
            comps2.month = 1
            comps2.day = -1
            let endOfMonth = Calendar.current.date(byAdding: comps2, to: startOfMonth)!
            let endDateString = dateFormatter.string(from: endOfMonth)
            btnDrop.setTitle(startDateString + " - " + endDateString, for: .normal)
            
            print("this month is selected")
            break
            
        case "Last Month":
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yy"
            let currentDate = Date()
            let startDateComponents:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: currentDate) as NSDateComponents
            startDateComponents.month -= 1
            let startDate = Calendar.current.date(from: startDateComponents as DateComponents)!
            let startDateString = dateFormatter.string(from: startDate)
            
            
            let endDateComponents:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: currentDate) as NSDateComponents
            endDateComponents.day = 1
            endDateComponents.day -= 1
            let endDate = Calendar.current.date(from: endDateComponents as DateComponents)!
            let endDateString = dateFormatter.string(from: endDate)
            btnDrop.setTitle(startDateString + " - " + endDateString, for: .normal)
            print("Last month is selecte")
            break
            
        default:
            break
        }
    }
    
    
}

