//
//  Router.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.
//

import Foundation
import UIKit


class Router: RouterProtocol {
    func showDetailsVC(parent: UIViewController, data: ListviewModel) {
        let vc = DetailViewController()
        vc.viewModel = data
        parent.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getListVC() -> UIViewController {
        let vc = ListViewController()
        vc.presenter = ListPresenter()
        vc.presenter?.interactor = Interactor()
        vc.presenter?.hostView = vc
        vc.presenter?.router = Router()
        let nav = UINavigationController(rootViewController: vc)
       
        return nav
    }
}
