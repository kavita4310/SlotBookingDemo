//
//  BookingVC.swift
//  SlotBookingApp
//
//  Created by kavita chauhan on 09/07/24.
//

import UIKit

class BookingVC: UIViewController {
    
    //MARK: Outlets
 
    @IBOutlet weak var bookingTblVw: UITableView!
    
    //MARK: Properties
    let sections = ["Requests","Active"]
    let productModel = ProductViewModel()
    var productList:[ProductsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProductList()
        bookingTblVw.delegate = self
        bookingTblVw.dataSource = self
        
        let nib = UINib(nibName: "BookingTCell", bundle: nil)
        self.bookingTblVw.register(nib, forCellReuseIdentifier: "BookingTCell")
    }
    
    //MARK: Product Api
    func getProductList(){
        productModel.fetchProducts()
        productModel.productSuccess = { result in
            self.productList = result
            DispatchQueue.main.async {
                self.bookingTblVw.reloadData()

            }
        }
        productModel.productFailure = { error in
            self.displayAlert(title: "Alert", msg: error.localizedDescription)
        }
    }
    
}
//MARK: TableView Delegate and datasource method
extension BookingVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTCell", for: indexPath) as! BookingTCell
        
        if indexPath.section == 1{
            cell.btnView.isHidden = true
            cell.lblProgress.isHidden = false
            cell.lblProgress.text = "In Progress"
            
        }
        
        cell.lblName.text = productList[indexPath.row].title
        cell.lblId.text = "ID :" + String(productList[indexPath.row].id)
        cell.lblPrice.text = "$" +  String(productList[indexPath.row].price)
        cell.lblDescription.text = productList[indexPath.row].description
        cell.lblHours.text = productList[indexPath.row].category
        cell.imgProduct.setImage(with: productList[indexPath.row].image)
        
        
        
        
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
        return UITableView.automaticDimension
    }
    
    
}
