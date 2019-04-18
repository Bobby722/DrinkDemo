//
//  ViewOrderViewController.swift
//  DrinkDemo
//
//  Created by 林嫈沛 on 2019/4/17.
//  Copyright © 2019 lohaslab. All rights reserved.
//

import UIKit

class ViewOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableview: UITableView!
    var item=[CdrinkOrder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden=false
        activityIndicator.startAnimating()
        download()
        // Do any additional setup after loading the view.
    }
    func download(){
        Cdrink.Drink.download(finish: {item in
            if let item = item{
                self.item = item
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden=true
                }
            }
        })
    }
    @IBAction func refreshBtn(_ sender: Any) {
        activityIndicator.isHidden=false
        activityIndicator.startAnimating()
        download()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DrinkTableViewCell else{return UITableViewCell()}
        cell.name.text = item[indexPath.row].name
        cell.drink.text = item[indexPath.row].drink
        cell.sweet.text = item[indexPath.row].sweet
        cell.ice.text = item[indexPath.row].ice
        cell.size.text = item[indexPath.row].size
        return cell
    }

}
