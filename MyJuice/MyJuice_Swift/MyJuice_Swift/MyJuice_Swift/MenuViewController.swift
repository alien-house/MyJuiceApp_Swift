//
//  MenuViewController.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/07.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myIndex = 0
    var c: UIImage!
    var selectedItems = [Int]()
    struct cellData {
        let cell : Int!
        let text : String!
        let image : UIImage!
    }
    var imageName:UIImage!
    let userDefaults = UserDefaults.standard
    
    var arrayOfCellDatas = [cellData]()
    @IBOutlet weak var menuTableView: UITableView!
    
    var imageName_bottles = [UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5"),UIImage(named:"6"),UIImage(named:"7"),UIImage(named:"8")]
    var nameArray = ["name 1","name 2","name 3","name 4","name 5","name 6","name 7","name 8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cart: [[String: Any]] = []
        
        self.arrayOfCellDatas = [cellData(cell: 1, text: "Apple(2.50)", image: #imageLiteral(resourceName: "AppleImage")),
                                 cellData(cell: 2, text: "Banana(2.50)", image: #imageLiteral(resourceName: "banana")),
                                 cellData(cell: 3, text: "Pineapple(3.00)", image: #imageLiteral(resourceName: "Pineapple")),
                                 cellData(cell: 4, text: "Watermelon(3.00)", image: #imageLiteral(resourceName: "watermelon")),
                                 cellData(cell: 5, text: "Orange(3.00)", image: #imageLiteral(resourceName: "orange")),
                                 cellData(cell: 6, text: "Strawberry(3.10)", image: #imageLiteral(resourceName: "strawberry")),
                                 cellData(cell: 7, text: "Celery(3.10)", image: #imageLiteral(resourceName: "celery")),
                                 cellData(cell: 8, text: "Tomato(2.75)", image: #imageLiteral(resourceName: "tomato")),
                                 cellData(cell: 9, text: "Grapes(2.75)", image: #imageLiteral(resourceName: "grapes")),
                                 cellData(cell: 10, text: "Avocado(2.50)", image: #imageLiteral(resourceName: "avocado")),
                                 cellData(cell: 11, text: "Carrot(2.00)", image: #imageLiteral(resourceName: "carrot"))]

        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
//        cart.append(["ingr": ["Apple","Pineapple"], "bottle": ["skull family"], "price": [12.05], "qty": [1]])
//        cart.append(["ingr": ["Banana","Mango","Strawberry"], "bottle": ["don't forget it!"], "price": [16], "qty": [5]])
//        
        
        userDefaults.set(cart, forKey: "myCart")
        userDefaults.synchronize()
        
//        
//        
//        let cart2 = userDefaults.array(forKey: "myCart")!
//        if(cart2.count > 0){
//            self.tabBarController?.viewControllers?[1].tabBarItem.badgeValue = String(cart2.count)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if let cart2 = self.userDefaults.array(forKey: "myCart"){
            if(cart2.count > 0){
                self.tabBarController?.viewControllers?[1].tabBarItem.badgeValue = String(cart2.count)
            }
        }
        self.tabBarController?.navigationItem.title = "Menu"
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell_Ingredient1", owner: self, options: nil)?.first as! TableViewCell_Ingredient1
        cell.Ingredient1.image = arrayOfCellDatas[indexPath.row].image
        cell.Ingredient_label1.text = arrayOfCellDatas[indexPath.row].text
        
        return cell
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfCellDatas.count
        
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellDatas[indexPath.row].cell == 1{
            return 60
            
        }
        else if arrayOfCellDatas[indexPath.row].cell == 2{
            return 60
            
        }
        else{
            return 60
            
        }
    }
    
    /* Will Select Row */
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        if let sr = tableView.indexPathsForSelectedRows {
            if sr.count <= 3 {
                let alertController = UIAlertController(title: "Oops", message:
                    "You are limited to \(3) selections", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                }))
                self.present(alertController, animated: true, completion: nil)
                
                return nil
            }
        }
        
        return indexPath
    }
    
    func tableView(_ UItableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if menuTableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark
        {
            self.unselectCell(indexPath: indexPath)
        }
        else
        {
            if (selectedItems.count < 3) {
                self.selectCell(indexPath: indexPath)
            }
            else
            {
                let alert = UIAlertController(title: "You can only select up to 3 items", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        if selectedItems.count == 3
        {
            createAlert(titleText: "3 Items Selected", messageText: "")
        }
    }
    
    func selectCell(indexPath:IndexPath) {
        print("😆")
//        print(self.arrayOfCellDatas[indexPath.row].image)
        self.imageName = self.arrayOfCellDatas[indexPath.row].image
        
        menuTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        selectedItems.append(indexPath.row)
    }
    
    func unselectCell(indexPath: IndexPath) {
        menuTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        selectedItems.remove(at: selectedItems.index(of: indexPath.row)!)
    }
    
    func createAlert(titleText: String, messageText: String ){
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { (action) in
                        self.nextView(sender: self)
//            self.performSegue(withIdentifier: "testSegue", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func nextView(sender: Any) {
        
        let IngredientDetailViewController: IngredientDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "IngredientDetailView") as! IngredientDetailViewController
        
//        StoreDetailViewController.atai = marker.userData as AnyObject
        
        //normal transit page
        //present(StoreDetailViewController, animated: true, completion: nil)
        
        IngredientDetailViewController.selectedItems = selectedItems
//        IngredientDetailViewController.image = self.arrayOfCellDatas[indexPath.row].image
        
//        let navi = UINavigationController(rootViewController: IngredientDetailViewController)
        // setting animation
//        navi.modalTransitionStyle = .crossDissolve
//        present(navi, animated: true, completion: nil)
        self.navigationController?.pushViewController(IngredientDetailViewController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let target = segue.destination as? IngredientDetailViewController
        target?.selectedItems = selectedItems
        print("prepare done")
    }
    
    

}
