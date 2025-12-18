//
//  ScanWordView.swift
//  final
//
//  Created by Fanny on 2025/12/19.
//

import SwiftUI
import VisionKit
import UIKit

struct ScanWordView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var scannedText: String = ""
    @State private var showScanner = false

    var body: some View {
        VStack(spacing: 16) {
            Text("掃描單字")
                .font(.title2)
                .bold()

            TextField("點一下掃到的單字會出現在這裡", text: $scannedText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("開啟相機掃描") {
                showScanner = true
            }
            .buttonStyle(.borderedProminent)

            Button("加入到歷史錯題") {
                let word = scannedText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !word.isEmpty else { return }

                appState.addWrongRecord(
                    question: "掃描新增單字",
                    correct: word,
                    selected: word
                )
                dismiss()
            }
            .buttonStyle(.bordered)
            .disabled(scannedText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Spacer()
        }
        .padding(.top)
        .sheet(isPresented: $showScanner) {
            DataScannerRepresentable(scannedText: $scannedText)
                .ignoresSafeArea()
        }
    }
}

// MARK: - DataScanner Bridge
struct DataScannerRepresentable: UIViewControllerRepresentable {
    @Binding var scannedText: String

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scanner = DataScannerViewController(
            recognizedDataTypes: [.text()],
            qualityLevel: .balanced,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        scanner.delegate = context.coordinator
        return scanner
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, DataScannerViewControllerDelegate {
        let parent: DataScannerRepresentable
        init(_ parent: DataScannerRepresentable) { self.parent = parent }

        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            if case .text(let textItem) = item {
                parent.scannedText = textItem.transcript
            }
        }
    }
}
