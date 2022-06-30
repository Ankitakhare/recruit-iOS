//
//  ViewController.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.
//

import UIKit

class ListViewController: UIViewController, ListViewProtocol {
    private var tableView: UITableView?

    private var circularViewDuration: TimeInterval = 10
    
    var presenter: PresenterProtocol?

   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ASBTransactionList"
        self.presenter?.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.presenter?.getData()
    }
   
   
   
    private func checkStates() {
        if self.presenter?.hasData ?? false {
            setupTableView()
        } else if let loadingState = self.presenter?.loadingState {
            switch loadingState {
            case .dataRefresh:
                self.view.backgroundColor = .white
                
            case .dataLoad:
                
                self.view.backgroundColor =  .white
            case .none:
                break
                // none
            }
        } else if self.presenter?.isError ?? false {
            let errorMessage = self.presenter?.getErrorMessage()
            let alert = UIAlertController(title: "Alert!", message: errorMessage, preferredStyle: .alert)
            self.present(alert, animated: true)
        }
    }
    
   
    
    func reloadView() {
        self.checkStates()
    }
    
    private func setupTableView() {
        guard let tableView = self.tableView else {
            tableView?.backgroundColor = .gray
            tableView = UITableView()
            tableView?.delegate = self
            tableView?.dataSource = self
            self.view.addSubview(tableView ?? UITableView())
            tableView?.fillSuperview()
            tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
            return
        }
        
        tableView.reloadData()
       
    }
    
}
    

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.yellow
       

        return vw
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        
        let viewModel = self.presenter?.getViewModel(for: indexPath.row)
        cell.textLabel?.text = viewModel?.transactionDate
        cell.detailTextLabel?.text = viewModel?.summary
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.handleSelection(index: indexPath.row)
    }
}





