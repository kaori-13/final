import Foundation

struct WrongRecord: Identifiable, Codable {
    var id = UUID()
    let question: String
    let correctAnswer: String
    let selectedAnswer: String
    let date: Date
}
