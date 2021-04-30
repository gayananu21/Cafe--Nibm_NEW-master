//
//  HistoryOrderDetailViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/27/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//
import UIKit
import Firebase
import Lottie
import Kingfisher

class HistoryOrderDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
//reference from admin account view controller
 var orderId = ""
 var total = Int()

    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var noItemsLabel: UILabel!
    
    
    @IBOutlet weak var cartTableView: UITableView!
    
     var refCarts: DatabaseReference!
     var refGetProcessingOrders: DatabaseReference!
    var refGetFoodImage: DatabaseReference!
    var refGetUserPhoneNumber: DatabaseReference!
    
     var cartList = [HistoryOrderDetail]()
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
           return cartList.count
       }
       
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
    
        return 100
        
    }
 
     
       
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           
         
         
           
         
           //creating a cell using the custom class
           let cell = tableView.dequeueReusableCell(withIdentifier: "History_ORDER_DETAIL_CELL", for: indexPath) as! HistoryOrderDetailTableViewCell
           
           
         
           
           //the artist object
           let cart: HistoryOrderDetail
        //getting the artist of selected position
               cart = cartList[indexPath.row]
           
        let listCount = String(cartList.count)
        self.noItemsLabel.text = "\(listCount)"
          
           //adding values to labels
       cell.foodImage.kf.indicatorType = .activity
        cell.foodImage.kf.setImage(with: URL(string:String(cart.foodImage ?? "")), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
          // cell.noFoods.text = cart.noItems
        cell.foodPrice.text = cart.price
        cell.foodName.text = cart.name
        
        cell.foodImage.kf.indicatorType = .activity
                    cell.foodImage.kf.setImage(with: URL(string:String(cart.foodImage ?? "")), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                    
                   cell.foodImage.heightAnchor.constraint(equalToConstant: 127).isActive = true
           
           
           
           
           //returning cell
           return cell
       }
    //printin order by onTapping print button
    @IBAction func btnTakeScreenShot(_ sender: UIButton) {
            
        printorder()
           
          
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
              
        
         
        // Do any additional setup after loading the view.
        
        cartTableView.delegate = self
                      cartTableView.dataSource = self
        
        
       
        
        
        
                      
                      //getting a reference to the node artists
        refCarts = Database.database().reference().child("History/\(self.orderId)");
         
                        
                        //observing the data changes
                             refCarts.observe(DataEventType.value, with: { (snapshot) in
                                 
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                        
                                     
                                     //clearing the list
                                     self.cartList.removeAll()
                                    
                                   // self.animationView.alpha = 0
                                     //iterating through all the values
                                     for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                         let cartObject = carts.value as? [String: AnyObject]
                                         let cartItemPrice  = cartObject?["foodPrice"]
                                         let cartNoUnits  = cartObject?["noFoods"]
                                         let cartAmount = cartObject?["amount"]
                                         let cartFoodName = cartObject?["foodName"]
                                         let cartImage = cartObject?["foodImage"]
                                       
                                       //self.total += cartAmount as! Int
                                        
                                         let stringfoodTotal = cartAmount as! String
                                         let foodTotal = Int(stringfoodTotal)
                                                                             
                                          self.total = self.total + (foodTotal ?? 0)
                                                                            self.totalLabel.text = "Rs. \(self.total)"
                                                                             
                                        
                                     
                                      
                                        if(cartFoodName != nil){
                                            
                                            //creating artist object with model and fetched values
                                            let cart = HistoryOrderDetail(name: cartFoodName as! String?, price: cartItemPrice as! String?,foodImage: cartImage as! String?, noItems: cartNoUnits as! String? )
                                               
                                            
                                               //appending it to list
                                               self.cartList.append(cart)
                                            
                                             self.cartTableView.reloadData()
                                            
                                        }
                                         
                                      
                                      
                                         
                                       
                                       
                                       
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
