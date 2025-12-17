//
//  Game.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appState: AppState
    @Binding var path: NavigationPath
    @State private var showCongrats = false

    struct Question {
        let text: String
        let options: [String]
        let correctAnswer: String
        var correctIndex: Int { options.firstIndex(of: correctAnswer) ?? 0 }
    }

    // ✅ 題庫（剛好 10 題）
    private let allQuestions: [Question] = [
        Question(
            text: """
                            
                            If you put a ______ under a leaking faucet, you will be surprised at the amount of water collected in
                                 24 hours.
                """,
            options: ["border", "timer", "container", "marker"],
            correctAnswer: "container"
        ),
        Question(
            text: """
                The local farmers’ market is popular as it offers a variety of fresh seasonal ______ to people in the community.
                """,
            options: ["produce", "fashion", "brand", "trend"],
            correctAnswer: "produce"
        ),
        Question(
            text: """
                As the years have passed by, many of my childhood memories are already ______; I can no longer recall clearly what happened back then.
                """,
            options: ["blurring", "trimming", "draining", "glaring"],
            correctAnswer: "blurring"
        ),
        Question(
            text: """
                Racist remarks are by nature ______ and hurtful, and should be avoided on all occasions.
                """,
            options: ["excessive", "furious", "offensive", "stubborn"],
            correctAnswer: "offensive"
        ),
        Question(
            text: """
                Not satisfied with the first ______ of her essay, Mary revised it several times before turning it in to the
                teacher.
                """,
            options: ["text", "brush", "draft", "plot"],
            correctAnswer: "draft"
        ),
        Question(
            text: """
                Left ______ for years, the deserted house was filled with a thick coating of dust and a smell of old
                damp wood.
                """,
            options: ["casual", "fragile", "remote", "vacant"],
            correctAnswer: "vacant"
        ),
        Question(
            text: """
                The high school student showed ______ courage when she helped the old man escape from the fire.
                """,
            options: ["gigantic", "exclusive", "multiple", "enormous"],
            correctAnswer: "enormous"
        ),
        Question(
            text: """
                Publicly financed projects are often ______ or delayed during tough economic times due to a lack of
                resources.
                """,
            options: ["halted", "hatched", "possessed", "reinforced"],
            correctAnswer: "halted"
        ),
        Question(
            text: """
                Despite his busy schedule, the President ______ the school’s graduation ceremony with his presence
                and a heartwarming speech.
                """,
            options: ["praised", "graced", "addressed", "credited"],
            correctAnswer: "graced"
        ),
        Question(
            text: """
                The manager of the company was sued for ______ abusing his colleagues, calling them “hopeless
                losers.”
                """,
            options: ["verbally", "dominantly", "legitimately", "relevantly"],
            correctAnswer: "verbally"
        ),
            Question(
                text: "People who desire a ______ figure should exercise regularly and maintain healthy eating habits.",
                options: ["spicy", "slender", "slight", "slippery"],
                correctAnswer: "slender"
            ),
            Question(
                text: "Watching the sun ______ from a sea of clouds is a must-do activity for all visitors to Ali Mountain.",
                options: ["emerging", "flashing", "rushing", "floating"],
                correctAnswer: "emerging"
            ),
            Question(
                text: "Do you know what time the next bus is ______? I’ve been waiting here for more than 30 minutes.",
                options: ["apt", "due", "bound", "docked"],
                correctAnswer: "due"
            ),
            Question(
                text: "The roasting heat and high ______ made me feel hot and sticky, no matter what I did to cool off.",
                options: ["density", "humidity", "circulation", "atmosphere"],
                correctAnswer: "humidity"
            ),
            Question(
                text: "Artwork created by truly great artists such as Picasso and Monet will no doubt ______ the test of time.",
                options: ["stay", "take", "serve", "stand"],
                correctAnswer: "stand"
            ),
            Question(
                text: "In some countries, military service is ______ for men only; women do not have to serve in the military.",
                options: ["forceful", "realistic", "compulsory", "distinctive"],
                correctAnswer: "compulsory"
            ),
            Question(
                text: "The team complained that its leader always took the ______ for all the hard work done by the team members.",
                options: ["advantage", "revenge", "remedy", "credit"],
                correctAnswer: "credit"
            ),
            Question(
                text: "Located at the center of the city, the business hotel ______ not only good service but also convenient public transport.",
                options: ["proposes", "contains", "promises", "confirms"],
                correctAnswer: "promises"
            ),
            Question(
                text: "As blood supplies have fallen to a critically low level, many hospitals are making an ______ for the public to donate blood.",
                options: ["appeal", "approach", "operation", "observation"],
                correctAnswer: "appeal"
            ),
            Question(
                text: "David felt disappointed when he found out that he could not choose his study partners, but would be ______ placed in a study group.",
                options: ["eligibly", "randomly", "apparently", "consequently"],
                correctAnswer: "randomly"
            ),
            Question(
                text: "The bus driver often complains about chewing gum found under passenger seats because it is ______ and very hard to remove.",
                options: ["sticky", "greasy", "clumsy", "mighty"],
                correctAnswer: "sticky"
            ),
            Question(
                text: "Jesse is a talented model. He can easily adopt an elegant ______ for a camera shoot.",
                options: ["clap", "toss", "pose", "snap"],
                correctAnswer: "pose"
            ),
            Question(
                text: "In order to draw her family tree, Mary tried to trace her ______ back to their arrival in North America.",
                options: ["siblings", "commuters", "ancestors", "instructors"],
                correctAnswer: "ancestors"
            ),
            Question(
                text: "Upon the super typhoon warning, Nancy rushed to the supermarket—only to find the shelves almost ______ and the stock nearly gone.",
                options: ["blank", "bare", "hollow", "queer"],
                correctAnswer: "bare"
            ),
            Question(
                text: "Even though Jack said “Sorry!” to me in person, I did not feel any ______ in his apology.",
                options: ["liability", "generosity", "integrity", "sincerity"],
                correctAnswer: "sincerity"
            ),
            Question(
                text: "My grandfather has astonishing powers of ______. He can still vividly describe his first day at school as a child.",
                options: ["resolve", "fraction", "privilege", "recall"],
                correctAnswer: "recall"
            ),
            Question(
                text: "Recent research has found lots of evidence to ______ the drug company’s claims about its “miracle” tablets for curing cancer.",
                options: ["provoke", "counter", "expose", "convert"],
                correctAnswer: "counter"
            ),
            Question(
                text: "Corrupt officials and misguided policies have ______ the country’s economy and burdened its people with enormous foreign debts.",
                options: ["crippled", "accelerated", "rendered", "ventured"],
                correctAnswer: "crippled"
            ),
            Question(
                text: "As a record number of fans showed up for the baseball final, the highways around the stadium were ______ with traffic all day.",
                options: ["choked", "disturbed", "enclosed", "injected"],
                correctAnswer: "choked"
            ),
            Question(
                text: "Studies show that ______ unbiased media are in fact often deeply influenced by political ideology.",
                options: ["undoubtedly", "roughly", "understandably", "supposedly"],
                correctAnswer: "supposedly"
            ),
            Question(
                text: "Tom is really a naughty boy. He likes to ______ and play jokes on his younger sister when their parents are not around.",
                options: ["alert", "spare", "tease", "oppose"],
                correctAnswer: "tease"
            ),
            Question(
                text: "Elderly shoppers in this store are advised to take the elevator rather than the ______, which may move too fast for them to keep their balance.",
                options: ["airway", "operator", "escalator", "instrument"],
                correctAnswer: "escalator"
            ),
            Question(
                text: "Upon hearing its master’s call, the dog wagged its tail, and followed her out of the room ______.",
                options: ["obediently", "apparently", "logically", "thoroughly"],
                correctAnswer: "obediently"
            ),
            Question(
                text: "Since many of our house plants are from humid jungle environments, they need ______ air to keep them green and healthy.",
                options: ["moist", "stale", "crisp", "fertile"],
                correctAnswer: "moist"
            ),
            Question(
                text: "The skydiver managed to land safely after jumping out of the aircraft, even though her ______ failed to open in midair.",
                options: ["glimpse", "latitude", "segment", "parachute"],
                correctAnswer: "parachute"
            ),
            Question(
                text: "The invention of the steam engine, which was used to power heavy machines, brought about a ______ change in society.",
                options: ["persuasive", "harmonious", "conventional", "revolutionary"],
                correctAnswer: "revolutionary"
            ),
            Question(
                text: "To encourage classroom ______, the teacher divided the class into groups and asked them to solve a problem together with their partners.",
                options: ["operation", "interaction", "adjustment", "explanation"],
                correctAnswer: "interaction"
            ),
            Question(
                text: "Lisa ______ onto the ground and injured her ankle while she was playing basketball yesterday.",
                options: ["buried", "punched", "scattered", "tumbled"],
                correctAnswer: "tumbled"
            ),
            Question(
                text: "Hundreds of residents received free testing ______ from the city government to find out if their water contained any harmful chemicals.",
                options: ["kits", "trials", "zones", "proofs"],
                correctAnswer: "kits"
            ),
            Question(
                text: "The 2011 Nobel Peace Prize was awarded ______ to three women for the efforts they made in fighting for women’s rights.",
                options: ["actively", "earnestly", "jointly", "naturally"],
                correctAnswer: "jointly"
            ),
            Question(
                text: "The company is ______ and making great profits under the wise leadership of the chief executive officer.",
                options: ["applauding", "flourishing", "circulating", "exceeding"],
                correctAnswer: "flourishing"
            ),
            Question(
                text: "It is absolutely ______ to waste your money on an expensive car when you cannot even get a driver’s license.",
                options: ["absurd", "cautious", "vigorous", "obstinate"],
                correctAnswer: "absurd"
            ),
            Question(
                text: "The problem of illegal drug use is very complex and cannot be traced to merely one ______ reason.",
                options: ["singular", "countable", "favorable", "defensive"],
                correctAnswer: "singular"
            ),
            Question(
                text: "The non-profit organization has ______ $1 million over five years to finance the construction of the medical center.",
                options: ["equipped", "resolved", "committed", "associated"],
                correctAnswer: "committed"
            ),
            Question(
                text: "One week after the typhoon, some bridges were finally opened and bus service ______ in the country’s most severely damaged areas.",
                options: ["departed", "resumed", "transported", "corresponded"],
                correctAnswer: "resumed"
            ),
            Question(
                text: "After hours of discussion, our class finally reached the ______ that we would go to Hualien for our graduation trip.",
                options: ["balance", "conclusion", "definition", "harmony"],
                correctAnswer: "conclusion"
            ),
            Question(
                text: "Jane ______ her teacher by passing the exam with a nearly perfect score; she almost failed the course last semester.",
                options: ["bored", "amazed", "charmed", "informed"],
                correctAnswer: "amazed"
            ),
            Question(
                text: "The vacuum cleaner is not working. Let’s send it back to the ______ to have it inspected and repaired.",
                options: ["lecturer", "publisher", "researcher", "manufacturer"],
                correctAnswer: "manufacturer"
            ),
            Question(
                text: "Due to the global financial crisis, the country’s exports ______ by 40 percent last month, the largest drop since 2000.",
                options: ["flattered", "transformed", "relieved", "decreased"],
                correctAnswer: "decreased"
            ),
            Question(
                text: "The potato chips have been left uncovered on the table for such a long time that they no longer taste fresh and ______.",
                options: ["solid", "crispy", "original", "smooth"],
                correctAnswer: "crispy"
            ),
            Question(
                text: "The townspeople built a ______ in memory of the brave teacher who sacrificed her life to save her students from a burning bus.",
                options: ["monument", "refugee", "souvenir", "firecracker"],
                correctAnswer: "monument"
            ),
            Question(
                text: "The students in Professor Smith’s classical Chinese class are required to ______ poems by famous Chinese poets.",
                options: ["construct", "expose", "recite", "install"],
                correctAnswer: "recite"
            ),
            Question(
                text: "Although Mr. Tang claims that the house belongs to him, he has not offered any proof of ______.",
                options: ["convention", "relationship", "insurance", "ownership"],
                correctAnswer: "ownership"
            ),
            Question(
                text: "Ancient Athens, famous for its early development of the democratic system, is often said to be the ______ of democracy.",
                options: ["mission", "target", "cradle", "milestone"],
                correctAnswer: "cradle"
            ),
            Question(
                text: "The candy can no longer be sold because it was found to contain artificial ingredients far beyond the ______ level.",
                options: ["abundant", "immense", "permissible", "descriptive"],
                correctAnswer: "permissible"
            ),
            Question(
                text: "Jack’s excellent performance in last week’s game has ______ all the doubts about his ability to play on our school basketball team.",
                options: ["erased", "canceled", "overlooked", "replaced"],
                correctAnswer: "erased"
            ),
            Question(
                text: "It is bullying to ______ a foreign speaker’s accent. No one deserves to be laughed at for their pronunciation.",
                options: ["mock", "sneak", "prompt", "glare"],
                correctAnswer: "mock"
            ),
            Question(
                text: "Mary lost ten kilograms in three months, so her ______ skin-tight jeans are now hanging off her hips.",
                options: ["barely", "evenly", "currently", "formerly"],
                correctAnswer: "formerly"
            ),
            Question(
                text: "The police officer showed us pictures of drunk driving accidents to highlight the importance of staying ______ on the road.",
                options: ["sober", "majestic", "vigorous", "noticeable"],
                correctAnswer: "sober"
            ),
            Question(
                text: "The claim that eating chocolate can prevent heart disease is ______ because there is not enough scientific evidence to support it.",
                options: ["creative", "disputable", "circular", "magnificent"],
                correctAnswer: "disputable"
            )
        ]
        // 你就一直加題目在這裡

    @State private var questions: [Question] = []

    // quiz progress
    @State private var currentIndex = 0
    @State private var correctCount = 0
    @State private var answeredCount = 0

    // ui state
    @State private var selectedIndex: Int? = nil
    @State private var showResult = false
    @State private var isLocked = false

    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()

            if questions.indices.contains(currentIndex) {
                let q = questions[currentIndex]

                VStack(alignment: .leading, spacing: 16) {

                    // HUD: progress + score
                    HStack {
                        Text("Q\(currentIndex + 1)/\(questions.count)")
                            .font(.headline)
                            .opacity(0.75)

                        Spacer()

                        Text("Score: \(correctCount)")
                            .font(.headline)
                    }

                    if answeredCount > 0 {
                        let rate =
                            Double(correctCount) / Double(answeredCount) * 100
                        Text(String(format: "Accuracy: %.0f%%", rate))
                            .font(.subheadline)
                            .opacity(0.7)
                    }

                    Text(q.text)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 6)

                    ForEach(q.options.indices, id: \.self) { i in
                        Button {
                            handleTap(option: i, correctIndex: q.correctIndex)
                        } label: {
                            HStack(spacing: 12) {
                                Text(letter(for: i) + ".")
                                    .fontWeight(.bold)

                                Text(q.options[i])

                                Spacer()

                                if showResult, let selectedIndex {
                                    if i == q.correctIndex {
                                        Image(
                                            systemName: "checkmark.circle.fill"
                                        )
                                    } else if i == selectedIndex {
                                        Image(systemName: "xmark.circle.fill")
                                    }
                                }
                            }
                            .padding()
                            .background(
                                optionBackground(
                                    i: i,
                                    correctIndex: q.correctIndex
                                )
                            )
                            .foregroundStyle(.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(isLocked)
                    }

                    if showResult {
                        Text(
                            selectedIndex == q.correctIndex
                                ? "✅ Correct!"
                                : "❌ Wrong. Correct answer: \(q.options[q.correctIndex])"
                        )
                        .font(.headline)
                        .padding(.top, 6)
                    }

                    Spacer()
                }
                .padding()
            } else {
                // Loading / placeholder while questions are being prepared
                ProgressView("載入題目中…")
                    .task {
                        if questions.isEmpty {
                            startNewGame()
                        }
                    }
            }
            if showCongrats {
                Color.black.opacity(0.001).ignoresSafeArea() // allow taps to pass; nearly transparent
                DotLottieView(fileName: "celebration_confetti", play: $showCongrats, loop: false)
                    .frame(width: 220, height: 220)
            }
        }
        .navigationTitle("下一個")
    }

    
    

    
    
    // MARK: - Quiz Logic

    private func handleTap(option i: Int, correctIndex: Int) {
        guard !isLocked else { return }

        let q = questions[currentIndex]

        selectedIndex = i
        showResult = true
        isLocked = true

        answeredCount += 1
        let isCorrect = (i == correctIndex)

        if !isCorrect {
            let selectedWord = q.options[i]
            appState.addWrongRecord(
                question: q.text,
                correct: q.options[correctIndex],
                selected: selectedWord
            )
        }

        if isCorrect {
            // 答對：播放動畫並很快換下一題
            showCongrats = true
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 900_000_000)  // 播放動畫時間 ~0.9 秒
                advanceOrFinish()
            }
        } else {
            // 答錯：停 3 秒再換下一題
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                advanceOrFinish()
            }
        }
    }

    @MainActor
    private func advanceOrFinish() {
        if currentIndex == questions.count - 1 {
            // ✅ 存高分
            let score = correctCount * 100
            appState.updateHighScore(
                player: appState.activePlayerName,
                newScore: score
            )

            // ✅ 回首頁（清空 NavigationStack）
            path = NavigationPath()
            return
        }

        // 下一題
        currentIndex += 1
        selectedIndex = nil
        showResult = false
        isLocked = false
        showCongrats = false
    }

    // MARK: - UI Helpers

    private func letter(for index: Int) -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init)
        return index < letters.count ? letters[index] : "#"
    }

    private func optionBackground(i: Int, correctIndex: Int) -> Color {
        guard showResult else { return .white.opacity(0.9) }
        if i == correctIndex { return .green.opacity(0.25) }
        if i == selectedIndex { return .red.opacity(0.20) }
        return .white.opacity(0.9)
    }

    private func startNewGame() {
        questions =
            allQuestions
            .shuffled()
            .prefix(10)
            .map { q in
                Question(
                    text: q.text,
                    options: q.options.shuffled(),
                    correctAnswer: q.correctAnswer
                )
            }

        currentIndex = 0
        correctCount = 0
        answeredCount = 0
    }
}

#Preview {
    NavigationStack {
        GameView(path: .constant(NavigationPath()))
            .environmentObject(AppState())
    }
}

