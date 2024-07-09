//
//  ProfileVC.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var profileTableVw: UITableView!
    
    @IBOutlet weak var txtView: UITextView!
    
    
    
    //MARK: Propeties
    let sections = ["Manage Bookings", "Account"]
    let productModel = ProductViewModel()
    var productList:[ProductsModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getProductList()
        profileTableVw.delegate = self
        profileTableVw.dataSource = self
        
        let nib = UINib(nibName: "ProfileTCell", bundle: nil)
        self.profileTableVw.register(nib, forCellReuseIdentifier: "ProfileTCell")
        
    

    }
    
    //MARK: Login API
    func getProductList(){
        productModel.fetchProducts()
        productModel.productSuccess = { result in
            self.productList = result
            DispatchQueue.main.async {
                self.profileTableVw.reloadData()

            }
        }
        productModel.productFailure = { error in
            self.displayAlert(title: "Alert", msg: error.localizedDescription)
        }
    }


}
//MARK: Table View delagate and Datasource method
extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTCell", for: indexPath) as! ProfileTCell
      
        cell.lblTitle.text = productList[indexPath.row].category
        cell.img.setImage(with: productList[indexPath.row].image)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = UIColor.clear
       let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.frame.width - 30, height: 20))
        label.font = UIFont.systemFont(ofSize: 15)

       label.text = "  " + sections[section]
       label.textColor = UIColor.gray
       
       headerView.addSubview(label)
       return headerView
   }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 35
        
   }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
