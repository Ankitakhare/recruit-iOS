//
//  DetailViewController.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var viewModel: ListviewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = viewModel?.transactionDate
        setUpView()
    }
    
    func setUpView() {
        let summary = UILabel(frame: CGRect(x: 0, y: 100.0, width: self.view.bounds.width, height: 60.0))
        summary.text = viewModel?.summary
        summary.textAlignment = NSTextAlignment.justified
        summary.textColor = UIColor.black
        summary.backgroundColor = UIColor.white
        self.view.addSubview(summary)
        lableView()
    }
    
    func lableView(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let lableDebit = UILabel(frame: CGRect(x: 0, y: 150.0, width: 200, height: 60.0))

        let value = viewModel?.debit
        guard let string = formatter.string(for: value) else { return }
        print(string)
        
        lableDebit.text = " Debit -" + " "  + string
        self.view.addSubview(lableDebit)
        
        lableDebit.textColor = .red
        lableDebit.backgroundColor = .white
        
        let lableCredit = UILabel(frame: CGRect(x: 0, y: 200.0, width: 200, height: 60.0))
        let value1 = viewModel?.credit
        guard let string = formatter.string(for: value1) else { return }
        print(string)
        lableCredit.text =  " Credit +" + " "  + string
        lableCredit.textColor = .green
        self.view.addSubview(lableCredit)
        lableDebit.backgroundColor = .white
        }
}


