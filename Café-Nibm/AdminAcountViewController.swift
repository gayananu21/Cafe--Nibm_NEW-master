//
//  AdminAcountViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/9/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import UIKit
import Firebase
import Lottie
import CoreData

class AdminAcountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var endText: UITextField!
    let datePicker = UIDatePicker()
    
    var total = Int()
    
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    
    
    var refCarts: DatabaseReference!
    var refDates: DatabaseReference!
       
    var cartList = [AdminAccountModel]()
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("you tap on \(indexPath.row)")
           
           
                  if(indexPath.row == indexPath.row){
                 
                   let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                   let VC1 = storyBoard.instantiateViewController(withIdentifier: "History_ORDER_DETAIL") as! HistoryOrderDetailViewController
                                // the order object
                                             //the artist obj
                    
                    
                             //the order object
                             let cart: AdminAccountModel
                             
                             //getting the artist of selected position
                             cart = cartList[indexPath.row]
                             
                             //adding values to labels
                             
                             //.orderId.text = cart.orderId
                    
                    
                VC1.orderId = cart.orderId ?? ""
                   
                    

                    self.navigationController?.pushViewController(VC1, animated: true)
                   
                  
                          
                         
                      }
    }
                  
       
       
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
              return cartList.count
          }
          
        
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           
       
           return 100
           
       }
    
        
          
          public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
              
            
            
              
            
              //creating a cell using the custom class
              let cell = tableView.dequeueReusableCell(withIdentifier: "ACCOUNT_CELL", for: indexPath) as! AdminAccountTableViewCell
              
              
            
              
              //the order object
             let cart: AdminAccountModel
           //getting the order of selected position
                  cart = cartList[indexPath.row]
              
             
              //adding values to labels
          
              cell.orderId.text = cart.orderId
           
              
              
              //returning cell
              return cell
          }
    
    func createDatePicker(){
        
        startText.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        self.startText.inputAccessoryView = toolbar
        
        startText.inputView = datePicker
        
       
        
       
    }
    
    @objc func donePressed(){
           datePicker.datePickerMode = UIDatePicker.Mode.date
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           let dateString = dateFormatter.string(from: datePicker.date)
           
           let toDate =  dateFormatter.date(from:dateString )!
           

        
           self.total = 0
           
           startText.text = dateString
           startLabel.text = dateString
           
           
           self.view.endEditing(true)
           
           //getting a reference to the node orders history
                 refCarts = Database.database().reference().child("History Account");
                                 
                   //filtering snapshot
                 let query_process = refCarts.queryOrdered(byChild: "date")
                                 
                        
                        query_process.observe(DataEventType.value, with: { snapshot in
                   
                                          //if the reference have some values
                                          if snapshot.childrenCount > 0 {
                                            
                                           
                                            
                                        
                                            
                                           
                                              //clearing the list
                                              self.cartList.removeAll()
                                             
                                            // self.animationView.alpha = 0
                                              //iterating through all the values
                                        for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                                  //getting values
                                                  let cartObject = carts.value as? [String: AnyObject]
                                                 let orderId  = cartObject?["orderId"]
                                                  //let amount  = cartObject?["amount"]
                                                  let date = cartObject?["date"]
                                                 
                                               

                                                let isoDate = date
                                                let customDateStart = self.startText.text!
                                              let customDateEnd = self.endText.text!
                                            

                                            let dateFormatter = DateFormatter()
                                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                            dateFormatter.dateFormat = "dd-MM-yyyy"
                                        let Newdate = dateFormatter.date(from:isoDate as! String)!
                                                let CustomNewdateStart = dateFormatter.date(from:customDateStart)
                                            let CustomNewdateEnd = dateFormatter.date(from:customDateEnd)
                                                                                      
                                                if(Newdate > CustomNewdateStart! && Newdate < CustomNewdateEnd!){
                                                                                          
                                                                                          //creating artist object with model and fetched values
                                            //creating artist object with model and fetched values
                                            let cart = AdminAccountModel(orderId: orderId as! String?,date: date as! String?)
                                               
                                                                                          
                                                                                             //appending it to list
                                            self.cartList.append(cart)
                                                                                          
                                    self.cartTableView.reloadData()
                                                                                          
                                                                                      }
                                                                                     //self.total +=
                                                
                                                
                                              }
                                              
                                              //reloading the tableview
                                              self.cartTableView.reloadData()
                                          }
                                        
                                         
                                        
                                       
                                        
                                      })
           
          
           
           
           
       }
    
    func createDatePickerEnd(){
           
           endText.textAlignment = .center
           
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedEnd))
           
           toolbar.setItems([doneBtn], animated: true)
           
           self.endText.inputAccessoryView = toolbar
           
           endText.inputView = datePicker
        
        
           
          
       }
    
    @objc func donePressedEnd(){
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        
     
        
        endText.text = dateString
        endLabel.text = dateString
        
         //self.totalAmount.text = ""
        self.total = 0
        
        self.view.endEditing(true)
        
        //getting a reference to the node artists
                        refCarts = Database.database().reference().child("History Account");
                                        
                                        //observing the data changes
                                            // refCarts.observe(DataEventType.value, with: { (snapshot) in
                                                 
                       // query_process.observe(.value, with: { snapshot in
                        let query_process = refCarts.queryOrdered(byChild: "date")
                                          //           query_process.observe(DataEventType.value, with: { (snapshot) in
                               
                               query_process.observe(DataEventType.value, with: { snapshot in
                            //query_process.ob
                                                
                                                 //if the reference have some values
                                                 if snapshot.childrenCount > 0 {
                                                   
                                                  
                                                   
                                               
                                                   
                                                  
                                                     //clearing the list
                                                     self.cartList.removeAll()
                                                    
                                                   // self.animationView.alpha = 0
                                                     //iterating through all the values
                                               for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                                         //getting values
                                                         let cartObject = carts.value as? [String: AnyObject]
                                                        let orderId = cartObject?["orderId"]                                                        // let amount  = cartObject?["amount"]
                                                         let date = cartObject?["date"]
                                                        
                                                      

                                                       let isoDate = date
                                                       let customDateStart = self.startText.text!
                                                     let customDateEnd = self.endText.text!
                                                   

                                                   let dateFormatter = DateFormatter()
                                                   dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                                   dateFormatter.dateFormat = "dd-MM-yyyy"
                                               let Newdate = dateFormatter.date(from:isoDate as! String)!
                                                       let CustomNewdateStart = dateFormatter.date(from:customDateStart)
                                                   let CustomNewdateEnd = dateFormatter.date(from:customDateEnd)
                                                                                             
                                                       if(Newdate > CustomNewdateStart! && Newdate < CustomNewdateEnd!){
                                                                                                 
                                                                                                 //creating artist object with model and fetched values
                                                //creating artist object with model and fetched values
                                                   let cart = AdminAccountModel(orderId: orderId as! String?,date: date as! String?)
                                                      
                                                                                                 
                                                                                                    //appending it to list
                                                   self.cartList.append(cart)
                                                                                                 
                                           self.cartTableView.reloadData()
                                                                                                 
                                                                                             }
                                                                                            //self.total +=
                                                       
                                                       
                                                     }
                                                     
                                                     //reloading the tableview
                                                     self.cartTableView.reloadData()
                                                 }
                                               
                                                
                                               
                                              
                                               
                                             })
       
        
        
        
    }
    
     @IBAction func btnTakeScreenShot(_ sender: UIButton) {
        
        
        printorder()
        
      }

      open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
          print("takeScreenshot")
          var screenshotImage :UIImage?
          let layer = UIApplication.shared.keyWindow!.layer
          let scale = UIScreen.main.scale
          UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
          guard let context = UIGraphicsGetCurrentContext() else {return nil}
          layer.render(in:context)
          screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
         
          return screenshotImage
      }
       
     
    @IBAction func onSignOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out", preferredStyle: .alert)
                                                                 alert.addAction(UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.destructive, handler: { action in
                                                                   
                                                                   do { try Auth.auth().signOut() }
                                                                            catch { print("already logged out") }
                                                                  
                                                                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                         let vc = storyboard.instantiateViewController(withIdentifier: "FIRST_VIEW")
                                                                          vc.modalPresentationStyle = .fullScreen
                                                                         vc.modalTransitionStyle = .crossDissolve
                                                                         self.present(vc, animated: true)
                                                                  
                                                                 }))
                                             alert.addAction(UIAlertAction(title: "Cancel ", style: .default, handler: { action in

                                              

                                             }))
                                                                 self.present(alert, animated: true, completion: nil)
        
    }
    
    func printorder(){
        
        print("takeScreenshot")
                 var screenshotImage :UIImage?
                 let layer = UIApplication.shared.keyWindow!.layer
                 let scale = UIScreen.main.scale
                 UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        let context = UIGraphicsGetCurrentContext() ?? "" as! CGContext
                 layer.render(in:context)
                 screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
                 UIGraphicsEndImageContext()
                
                  
        
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary: nil)
        
        printInfo.jobName = "Printing Order ids"
        printInfo.outputType = .photo
        
        
        
        printController.printInfo = printInfo
        printController.printingItem = screenshotImage
        
        printController.present(animated: true) { (_, isPrinted, error) in
            if error == nil {
                if isPrinted {
                    let alert = UIAlertController(title: "Success", message: "Order History Printed Successfully.", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                 
                                                                          

                                                            }))
                                                                                self.present(alert, animated: true, completion: nil)
                    print("Image is printed")
                }
                else{
                    print("Image is not printed")
                    
                    let alert = UIAlertController(title: "Error", message: "Error While Printing Order History.", preferredStyle: .alert)
                                                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                                    
                                                                                             

                                                                               }))
                                                                                                   self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if NetworkMonitor.shared.isConnected == false {
                  
                  print("No network")
                  
                  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                                   let VC1 = storyBoard.instantiateViewController(withIdentifier: "NO_NETWORK") as! NoNetworkViewController
                                             
                                 
                                 
                                 

                                                                     
                                        
                                        self.navigationController?.pushViewController(VC1, animated: true)
              }
              
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
                       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                       
                       //We need to create a context from this container
                       let managedContext = appDelegate.persistentContainer.viewContext
                       
                       //Prepare the request of type NSFetchRequest  for the entity
                       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewOrders")
                       
              
                       do {
                           let result = try managedContext.fetch(fetchRequest)
                           for data in result as! [NSManagedObject] {
                               print(data.value(forKey: "status") as! String)
                               
                               if(data.value (forKey: "status") as! String == "true"){
                                   
                                   let notificationType = "You have received some new orders. Please check them before continue."
                                               let alertTitle = "New Orders Available"
                                                          
                                                        self.appDelegate?.scheduleNotification(notificationType: notificationType, alertTitle: alertTitle)
                                                     
                               }
                           }
                           
                       } catch {
                           
                           print("Failed")
                       }
        
        
        
                            /*
                               // MARK: - Check Customer Arriving Status(Distance)

                               // In here we are checking core data for customer arriving status. If arriving we giving a local notification to manager.If he is not in the order screen.
                              
                               */
                            
        
                              //Prepare the request of type NSFetchRequest  for the entity
                              let fetchRequestArriving = NSFetchRequest<NSFetchRequestResult>(entityName: "ArrivingStatus")
                              
                     
                              do {
                                  let result = try managedContext.fetch(fetchRequestArriving)
                                  for data in result as! [NSManagedObject] {
                                      print(data.value(forKey: "status") as! String)
                                      
                                      if(data.value (forKey: "status") as! String == "true"){
                                          
                                          let notificationType = "A customer is arriving. Please check orders for delivery."
                                                      let alertTitle = "New Orders Available"
                                                                 
                                                               self.appDelegate?.scheduleNotification(notificationType: notificationType, alertTitle: alertTitle)
                                                            
                                      }
                                  }
                                  
                              } catch {
                                  
                                  print("Failed")
                              }
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        
        
        self.startText.text = result
        self.endText.text = result
        
        let toDate = formatter.date(from:result)
        
        createDatePicker()

        createDatePickerEnd()
       
        cartTableView.delegate = self
                      cartTableView.dataSource = self
                      
                      //getting a reference to the node artists
        refCarts = Database.database().reference().child("History Account");
                        
                        //observing the data changes
                            // refCarts.observe(DataEventType.value, with: { (snapshot) in
                                 
       // query_process.observe(.value, with: { snapshot in
        let query_process = refCarts.queryOrdered(byChild: "date")
                   //           query_process.observe(DataEventType.value, with: { (snapshot) in
        
        query_process.observe(DataEventType.value, with: { snapshot in
            //query_process.ob
                                
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                                  
                                   
                               
                                   
                                  
                                     //clearing the list
                                     self.cartList.removeAll()
                                    
                                   // self.animationView.alpha = 0
                                     //iterating through all the values
                                     for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                         let cartObject = carts.value as? [String: AnyObject]
                                        let orderId  = cartObject?["orderId"]
                                         let date = cartObject?["date"]
                                        
                                        let isoDate = date
                                        let customDate = "01/01/2021"

                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                        dateFormatter.dateFormat = "dd-MM-yyyy"
                                        let Newdate = dateFormatter.date(from:isoDate as! String)!
                                        let CustomNewdate = dateFormatter.date(from:customDate)!
                                        
                                        if(Newdate > CustomNewdate){
                                            
                                            //creating artist object with model and fetched values
                                            let cart = AdminAccountModel(orderId: orderId as! String?, date: date as! String?)
                                               
                                            
                                               //appending it to list
                                               self.cartList.append(cart)
                                            
                                             self.cartTableView.reloadData()
                                            
                                        }
                                       //self.total += cartAmount as! Int
                                     
                                      
                                        
                                            
                                            
                                        
                                         
                                      
                                      
                                         
                                       
                                       
                                       
                                     }
                                     
                                     //reloading the tableview
                                     self.cartTableView.reloadData()
                                 }
                               
                                
                               
                              
                               
                             })
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
