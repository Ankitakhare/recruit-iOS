//
//  Interactor.swift
//  TestAnkita
//
//  Created by ankita khare on 29/06/22.
//

import Foundation

struct NetworkModel: Codable {
    let id: Int
    let transactionDate: String
    let summary: String
    let debit: Double
    let credit:Double
   
    
}

class Interactor: InteractorProtocol {
    
    func getList(completion: @escaping(Result<[Model],ApiError>)->()) {
        guard let url = URL(string: "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json")  else {
            completion(.failure(ApiError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(ApiError.url(error)))
            }else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
            }else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let networkModels = try decoder.decode([NetworkModel].self, from: data)
                    
                    completion(Result.success(self.getModelFromNetworkModel(info: networkModels)))
                    
                }catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    private func getModelFromNetworkModel(info: [NetworkModel]) -> [Model] {
        var array: [Model] = []
        
        for item in info {
            let model = Model(id: item.id , transactionDate: item.transactionDate , summary: item.summary , debit: item.debit ,credit: item.credit )
            array.append(model)
        }
        
        return array
    }
}
