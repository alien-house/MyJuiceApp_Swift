//
//  TableViewController.swift
//  MyJuice_HS
//
//  Created by HannahPark on 2017-04-07.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

var myIndex = 0

var selectedImage: UIImage!


struct cellData {
    
    let cell : Int!
    let text : String!
    let image : UIImage!
    
}

class TableViewController: UITableViewController {
    
    var arrayOfCellData = [cellData]()
    
    @IBOutlet var Photo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        arrayOfCellData = [cellData(cell: 1, text: "Apple", image: #imageLiteral(resourceName: "AppleImage")),
                           cellData(cell: 1, text: "Banana", image: #imageLiteral(resourceName: "banana")),
                           cellData(cell: 1, text: "Pineapple", image: #imageLiteral(resourceName: "Pineapple")),
                           cellData(cell: 1, text: "Watermelon", image: #imageLiteral(resourceName: "watermelon")),
                           cellData(cell: 1, text: "Orange", image: #imageLiteral(resourceName: "orange")),
                           cellData(cell: 1, text: "Strawberry", image: #imageLiteral(resourceName: "strawberry")),
                           cellData(cell: 1, text: "Celery", image: #imageLiteral(resourceName: "celery")),
                           cellData(cell: 1, text: "Tomato", image: #imageLiteral(resourceName: "tomato")),
                           cellData(cell: 1, text: "Grapes", image: #imageLiteral(resourceName: "grapes")),
                           cellData(cell: 1, text: "Avocado", image: #imageLiteral(resourceName: "avocado")),
                           cellData(cell: 1, text: "Carrot", image: #imageLiteral(resourceName: "carrot"))]
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell_Ingredient1", owner: self, options: nil)?.first as! TableViewCell_Ingredient1
        cell.imageView?.image = UIImage(named: "AppleImage")
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return arrayOfCellData.count
//        
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfCellData[indexPath.row].cell == 1{
            
            let cell = Bundle.main.loadNibNamed("TableViewCell_Ingredient1", owner: self, options: nil)?.first as! TableViewCell_Ingredient1
            cell.Ingredient1.image = arrayOfCellData[indexPath.row].image
            cell.Ingredient_label1.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
        else if arrayOfCellData[indexPath.row].cell == 2{
            let cell = Bundle.main.loadNibNamed("TableViewCell_Ingredient1", owner: self, options: nil)?.first as! TableViewCell_Ingredient1
            cell.Ingredient1.image = arrayOfCellData[indexPath.row].image
            cell.Ingredient_label1.text = arrayOfCellData[indexPath.row].text
            
            return cell
            
            
        }
        else{
            
            let cell = Bundle.main.loadNibNamed("TableViewCell_Ingredient1", owner: self, options: nil)?.first as! TableViewCell_Ingredient1
            cell.Ingredient1.image = arrayOfCellData[indexPath.row].image
            cell.Ingredient_label1.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1{
            return 60
            
        }
        else if arrayOfCellData[indexPath.row].cell == 2{
            return 60
            
        }
        else{
            return 60
            
            
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row)selected")
        selectedImage = arrayOfCellData[indexPath.row].image
        performSegue(withIdentifier: "IngredientDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "IngredientDetail") {
            _ = segue.destination as! IngredientDetailViewController
        }
    }

}
