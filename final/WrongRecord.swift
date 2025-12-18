import Foundation

struct WrongRecord: Identifiable {
    let id = UUID()
    let question: String
    let correctAnswer: String
    let selectedAnswer: String
    let date: Date
}


