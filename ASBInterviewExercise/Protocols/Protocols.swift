//
//  Protocols.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.

import Foundation
import UIKit

enum ApiError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
}

struct Model {
    let id: Int
    let transactionDate: String
    let summary: String
    let debit: Double
    let credit:Double
}

struct ListviewModel {
    let id: Int
    let transactionDate: String
    let summary: String
    let debit: Double
    let credit:Double
    
}

enum LoadingState {
    case dataRefresh,
    dataLoad,
    none
}

protocol ListViewProtocol: AnyObject {
    func reloadView()
    var presenter: PresenterProtocol? {get set}
}

protocol PresenterProtocol {
    var hostView: ListViewProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var router: RouterProtocol? { get set }
    var loadingState: LoadingState? { get set }
    var isError: Bool { get set}
    var hasData: Bool {get set}
    func getData()
    func getErrorMessage() -> String
    func getViewModel(for indexPath: Int) -> ListviewModel
    func getNumberOfItems() -> Int
    func handleSelection(index: Int)
}

protocol InteractorProtocol {
    func getList(completion: @escaping(Result<[Model],ApiError>)->())
}

protocol RouterProtocol {
    func showDetailsVC(parent: UIViewController, data: ListviewModel)
    func getListVC() -> UIViewController
}
