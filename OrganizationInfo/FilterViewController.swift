//
//  FilterViewController.swift
//  OrganizationInfo
//
//  Created by karthi on 12/1/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    var departmentListTOShow: String = " "
    @IBOutlet var departmentListPicker: UIView!

    @IBOutlet weak var employeeTableView: UITableView!
   
    @IBOutlet weak var departmentNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return ViewController.vcObj.departmentsList.count
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        departmentListTOShow = ViewController.vcObj.departmentsList[row].departmentname!
        
        ViewController.vcObj.filterNamesBasedOnDepartment(departmentListTOShow: departmentListTOShow)
        employeeTableView.reloadData()
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return ViewController.vcObj.departmentsList[row].departmentname!
    }
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label = UILabel()
        
        
        let data = ViewController.vcObj.departmentsList[row].departmentname!
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightRegular)])
        label.attributedText = title
        label.textAlignment = .center
        return label
        
    }
    
public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return ViewController.vcObj.Emp.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = employeeTableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)

        let empValueToDisp: Employee = ViewController.vcObj.Emp[indexPath.row]
        
        cell.textLabel?.text = empValueToDisp.name
      //  print(empValueToDisp.name)

       // let person = people[indexPath.row]
        
              // cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
