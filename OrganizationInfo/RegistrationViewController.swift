//
//  RegistrationViewController.swift
//  OrganizationInfo
//
//  Created by karthi on 11/29/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var selectedPickerValue: String = " "

    @IBOutlet weak var nameValue: UITextField!
    @IBOutlet weak var deptValue: UIPickerView!
    
    @IBOutlet weak var enrollmentLabel: UILabel!
    
    @IBOutlet weak var addressValue: UITextView!
    @IBOutlet weak var bloodGroupValue: UITextField!
    @IBOutlet weak var ageValue: UITextField!
    @IBOutlet weak var mobileValue: UITextField!
   
   

    @IBAction func registerAction(_ sender: AnyObject) {
        let name = nameValue.text
        let address = addressValue.text
        let bloodgroup = bloodGroupValue.text
        
        if (nameValue.text?.isEmpty)!
        {
            let title = "Error"
            let value = "Name field"
            alert(value: value, title: title)
        }
        else if (ageValue.text?.isEmpty)!
        {
            let title = "Error"
            let value = "Age field"
            alert(value: value, title: title)
        }
        else if (mobileValue.text?.isEmpty)!
        {
            let title = "Error"
            let value = "Mobile field"
            alert(value: value, title: title)
        }
        else if (bloodGroupValue.text?.isEmpty)!
        {
            let title = "Error"
            let value = "Blood Group field"
            alert(value: value, title: title)
        }
        else if (addressValue.text?.isEmpty)!
        {
            let title = "Error"
            let value = "Address field"
            alert(value: value, title: title)
        }
       
        
            
        else
        {
            let mobile = Int(mobileValue.text!)!
            let age = Int(ageValue.text!)!
            self.register(name: name!, address: address!, age: age, mobile: mobile, bloodgroup: bloodgroup!)
            
        }
     alert1(value: "Details Registered Successfully!", title: "Successfull Registration")
     clear()

    }
    @IBAction func resetAction(_ sender: AnyObject) {
        nameValue.text = ""
        addressValue.text = ""
        ageValue.text = ""
        mobileValue.text = ""
        nameValue.text = ""
        bloodGroupValue.text = ""
       
        
    }
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bloodGroupLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
 
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        ViewController.vcObj.fetch()
        //deptValue.dataSource = self
       // deptValue.delegate = self
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
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
       selectedPickerValue = ViewController.vcObj.departmentsList[row].departmentname!
        
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
    
    func register(name: String, address: String, age: Int, mobile: Int, bloodgroup: String) {
        
        if #available(iOS 10.0, *) {
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            let managedContext =
                appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
        }
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Employee",
                                       in: managedContext)!
        let person: Employee = NSManagedObject(entity: entity, insertInto: managedContext) as! Employee
       // let person = Employee(context: NSManagedObjectContext)
        // personDetails.setValue(deptName.last, forKey: "departmentname")
        // personDetails.setValue(deptId.last, forKey: "departmentId")
        // personDetails = Department(context: managedContext)

        //var personDetails = Employee()

        person.name = name
        person.address = address
        person.age = Int16(age)
        person.bloodgroup = bloodgroup
        person.mobile = Int64(mobile)
//print(selectedPickerValue)
        ViewController.vcObj.fetchDepartmentFromDb(selectedPickerValue: selectedPickerValue, person: person)
      /*  do {
            try managedContext.save()
            ViewController.vcObj.employee.append(person)
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }*/
    }

    func alert(value: String, title: String)
    {
        let alertController = UIAlertController(title: "\(title)", message:
            "\(value) is Empty!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    func alert1(value: String, title: String)
    {
        let alertController = UIAlertController(title: "\(title)", message:
            "\(value)!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }

    func clear()
    {
        nameValue.text = ""
        ageValue.text = ""
        mobileValue.text = ""
        bloodGroupValue.text = ""
        addressValue.text = ""
        
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
