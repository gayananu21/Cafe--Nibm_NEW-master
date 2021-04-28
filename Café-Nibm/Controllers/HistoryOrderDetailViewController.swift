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
             self.takeScreenshot()
           
           let alert = UIAlertController(title: "Success", message: "Order Item History Printed Successfully", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                              
                                                       

                                         }))
                                                             self.present(alert, animated: true, completion: nil)
         }
        //Order Printing function
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
             if let image = screenshotImage, shouldSave {
                 UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
             }
             return screenshotImage
         }
          
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         
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
                                         //let cartAmount = cartObject?["amount"]
                                         let cartFoodName = cartObject?["foodName"]
                                         let cartImage = cartObject?["foodImage"]
                                       
                                       //self.total += cartAmount as! Int
                                     
                                      
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
