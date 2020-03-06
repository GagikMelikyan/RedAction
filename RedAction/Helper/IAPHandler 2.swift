//
//  IAPHandler.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 9/6/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation
import StoreKit

class IAPHolder: NSObject {
    private override init() {}
    static let shared = IAPHolder()
    
    var products = [SKProduct]()
    let paymentQue = SKPaymentQueue.default()
    
    func getProducts() {
        
        let products: Set = [IAPProduct.autoRenewingPurchase.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQue.add(self)
        
    }
    
    func purchaseProduct(product: IAPProduct) {
        guard let productToPurchase = products.filter({$0.productIdentifier == product.rawValue}).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQue.add(payment)
    }
    
    func restorePurchases() {
        print("Restoring purchases")
        paymentQue.restoreCompletedTransactions()
    }
}

extension IAPHolder: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}

extension IAPHolder: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch transaction.transactionState {
            case .purchasing:
                break
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    
}
