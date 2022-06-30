//
//  ListPresenter.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.
//

import Foundation
import UIKit

class ListPresenter: PresenterProtocol {
    weak var hostView: ListViewProtocol?
    var interactor: InteractorProtocol?
    var router: RouterProtocol?
    var loadingState: LoadingState?
    var isError: Bool = false
    var hasData: Bool = false

    private var error: ApiError?
    private var model: [Model] = []
 
    func getData() {
        self.hasData = false
        if model.count == 0 {
            self.loadingState = .dataLoad
        } else {
            self.loadingState = .dataRefresh
        }
        
        self.hostView?.reloadView()
 
        self.interactor?.getList(completion: { result in
            switch result {
            case .success(let model):
                self.model = model
                self.hasData = true
            case .failure(let error):
                self.error = error
                self.isError = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hostView?.reloadView()
            }
        })
    }
    
    func getErrorMessage() -> String {
        return self.error?.description ?? ""
    }
    
    func getViewModel(for indexPath: Int) -> ListviewModel {
        let model = self.model[indexPath]
        let vm = ListviewModel(id: model.id, transactionDate: model.transactionDate, summary: model.summary, debit: model.debit, credit: model.credit)
        
        return vm
    }
    
    func getNumberOfItems() -> Int {
        return self.model.count
    }
    
    func handleSelection(index: Int) {
        guard let vc = self.hostView as? UIViewController else {return}
        let model = self.model[index]
        let vm = ListviewModel(id: model.id, transactionDate: model.transactionDate, summary: model.summary, debit: model.debit, credit: model.credit)
        
        self.router?.showDetailsVC(parent: vc, data: vm)
    }
}
