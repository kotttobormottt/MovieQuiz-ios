//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Andrey Zharov on 02.01.2024.
//

import UIKit

// Структура-модель для отображения аллерта
struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: ((UIAlertAction) -> Void)?
}
