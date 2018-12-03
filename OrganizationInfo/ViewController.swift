//
//  ViewController.swift
//  OrganizationInfo
//
//  Created by karthi on 11/28/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit
import CoreData
var pickerData: [String] = []
var departments: [NSManagedObject] = []
var managedContext = NSManagedObjectContext()
@available(iOS 10.0, *)
var appDelegate = AppDelegate()
var flag:Bool = true

class ViewController: UIViewController, UITextFieldDelegate {
    
   static let vcObj = ViewController()
    var employee: [NSManagedObject] = []
    var departmentsList: [Department] = []
    var requiredDepartment: [Department] = []
    var requiredDepartmentNames: [Department] = []

    var Emp: [Employee] = []
    
   // var dept: [String] = []
    var value: String = ""
    var heading: String = ""
    var dbValues: [String] = []
    var deptName: [String] = []
    var deptId: [String] = []
    var departValues: [String] = [] // duplicate
    
    
    @IBAction func addAction(_ sender: AnyObject) {

        if (departmentNameValue.text?.isEmpty)!
        {
            value = "Department Name Field is Empty"
            heading = "Error!"
        alert(value: value, heading: heading)
        }
        else if(departmentIdValue.text?.isEmpty)!
        {
            value = "Department Id Field is Empty"
            heading = "Error!"
            alert(value: value, heading: heading)
        }
            else
        {
            fetch()
            for values in departmentsList
            {
                if ((values.departmentId) == (departmentIdValue.text)!)
                {
                    alert(value: "Department Id Already Exists", heading: "error")
                    flag = false
                
                }
                
            }
            
        }
        if(flag == true)
        {
            deptName.append(departmentNameValue.text!)
            deptId.append(departmentIdValue.text!)
            if #available(iOS 10.0, *) {
                guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
                    return
                }
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 10.0, *) {
                managedContext =
                    appDelegate.persistentContainer.viewContext
            } else {
                // Fallback on earlier versions
            }
            let entity = NSEntityDescription.entity(forEntityName: "Department",in: managedContext)!
            
            let departmentDetails: Department = NSManagedObject(entity: entity,insertInto: managedContext) as! Department
            // departmentDetails.setValue(deptName.last, forKey: "departmentname")
            // departmentDetails.setValue(deptId.last, forKey: "departmentId")
            
            //var departmentDetails = Department()
            
            if #available(iOS 10.0, *) {
                
                // departmentDetails = Department(context: managedContext)
            } else {
                // Fallback on earlier versions
            }
            departmentDetails.departmentname = deptName.last
            departmentDetails.departmentId = deptId.last!
            
            do {
                try managedContext.save()
                departments.append(departmentDetails)
                alert(value: "Department Created Successfully" , heading: "Successfully Registered!")
                clear()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        
        }
        
                                   }
    @IBOutlet weak var departmentIdValue: UITextField!
    @IBOutlet weak var departmentNameValue: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var departmentId: UILabel!
    @IBOutlet weak var departmentName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        departmentIdValue.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetch()
    {
        if #available(iOS 10.0, *) {
            appDelegate =
                (UIApplication.shared.delegate as? AppDelegate)!
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10.0, *) {
             managedContext =
                appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
        }
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Department")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "departmentname", ascending: true)]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "departmentId", ascending: true)]
        
        
        do {
            departmentsList = try managedContext.fetch(fetchRequest) as! [Department]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }

    func alert(value: String, heading: String)
    {
        let alertController = UIAlertController(title: "\(heading)", message:
            "\(value)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        flag = true
    }
func clear()
{
    departmentNameValue.text = ""
    departmentIdValue.text = ""
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func fetchDepartmentFromDb(selectedPickerValue: String, person: Employee)
{
    if #available(iOS 10.0, *) {
        appDelegate =
            (UIApplication.shared.delegate as? AppDelegate)!
    } else {
        // Fallback on earlier versions
    }
    
    if #available(iOS 10.0, *) {
        managedContext =
            appDelegate.persistentContainer.viewContext
    } else {
        // Fallback on earlier versions
    }
    
    let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Department")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "departmentname", ascending: true)]
    fetchRequest.predicate = NSPredicate(format: "departmentname == %@", selectedPickerValue)
    
    do {
        requiredDepartment = try managedContext.fetch(fetchRequest) as! [Department]
        requiredDepartment.first?.addToEmployees(person)
        try managedContext.save()
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }

    }
    func filterNamesBasedOnDepartment(departmentListTOShow: String)
    {
        
        if #available(iOS 10.0, *) {
            appDelegate =
                (UIApplication.shared.delegate as? AppDelegate)!
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10.0, *) {
            managedContext =
                appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
        }
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Department")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "departmentname", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "departmentname == %@", departmentListTOShow )
        
        do {
            requiredDepartmentNames = try managedContext.fetch(fetchRequest) as! [Department]
            for values in requiredDepartmentNames
            {
             Emp = values.employees?.allObjects as! [Employee]

            }
        }
            catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        
        
        
        
    }

    
    
}



