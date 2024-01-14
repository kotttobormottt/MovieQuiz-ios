//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Andrey Zharov on 02.01.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
