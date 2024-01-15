//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Andrey Zharov on 02.01.2024.
//

import UIKit

class AlertPresenter {
    weak var delegate: UIViewController?
    
    init(delegate: UIViewController?) {
        self.delegate = delegate
    }
    
    func showAlert(result: AlertModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default, handler: result.completion)
        alert.addAction(action)
        delegate?.present(alert, animated: true, completion: nil)
    }
}
