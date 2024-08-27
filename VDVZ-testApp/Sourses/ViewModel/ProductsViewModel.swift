//
//  ProductsViewModel.swift
//  VDVZ-testApp
//
//  Created by Ivan Rybkin on 27.08.2024.
//

import Foundation

class ProductsViewModel {
    var sections: [Section] = []
    var products: [Product] = []

    func fetchProducts(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://szorin.vodovoz.ru/newmobile/glavnaya/super_top.php?action=topglav") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                if responseData.status == "Success" {
                    self.sections = responseData.sections
                    self.products = responseData.products
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
