//
//  WalletVC.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit

class WalletVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var walletTableVw: UITableView!
    @IBOutlet weak var lblWalletBalance: UILabel!
    
    //MARK: Properties
    
    let sections = ["Transactions"]
    let productModel = ProductViewModel()
    var productList:[ProductsModel] = []
    var total: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        getProductList()
        walletTableVw.delegate = self
        walletTableVw.dataSource = self
        
        let nib = UINib(nibName: "WalletTCell", bundle: nil)
        self.walletTableVw.register(nib, forCellReuseIdentifier: "WalletTCell")
    }
    
    //MARK: Product Api
    func getProductList(){
        productModel.fetchProducts()
        productModel.productSuccess = { result in
            self.productList = result
            for value in self.productList{
                self.total += Double(value.price)
            }
            
            DispatchQueue.main.async {
                let roundedString = String(format: "%.2f", self.total)
                if let roundedNumber = Double(roundedString) {
                    self.lblWalletBalance.text = "$" + String(roundedNumber)
                }
                
                self.walletTableVw.reloadData()

            }
        }
        productModel.productFailure = { error in
            self.displayAlert(title: "Alert", msg: error.localizedDescription)
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
//MARK: TableView Delegate method 
extension WalletVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTCell", for: indexPath) as! WalletTCell
      
        cell.lblName.text = productList[indexPath.row].title
        cell.lblDescription.text = productList[indexPath.row].category
        cell.lblPrice.text = "$" + String(productList[indexPath.row].price)
        cell.lblHours.text = "12/04/2022, 2:04 PM"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = UIColor(named: "cellClr")
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
        return UITableView.automaticDimension
    }
    
    
}
