import Foundation

final class ExecutionViewModel: ObservableObject {
    let routine: Routine
    @Published private(set) var currentStepIndex = 0
    @Published var remainingSeconds: Int
    @Published var isPaused = false
    @Published private(set) var isCompleted = false

    init(routine: Routine) {
        self.routine = routine
        self.remainingSeconds = routine.steps.first?.seconds ?? 20
    }

    var currentStep: RoutineStep {
        routine.steps[currentStepIndex]
    }

    var progress: Double {
        let total = max(currentStep.seconds, 1)
        return min(max(1 - Double(remainingSeconds) / Double(total), 0), 1)
    }

    var stepProgressText: String {
        "\(currentStepIndex + 1) / \(routine.steps.count)"
    }

    func tick() -> Bool {
        guard !isPaused, !isCompleted else { return false }
        if remainingSeconds > 1 {
            remainingSeconds -= 1
            return false
        }
        return advance()
    }

    func togglePause() {
        isPaused.toggle()
    }

    func previous() {
        guard currentStepIndex > 0 else {
            remainingSeconds = currentStep.seconds
            return
        }
        currentStepIndex -= 1
        remainingSeconds = currentStep.seconds
        isCompleted = false
    }

    func advance() -> Bool {
        guard currentStepIndex < routine.steps.count - 1 else {
            isCompleted = true
            isPaused = true
            remainingSeconds = 0
            return true
        }
        currentStepIndex += 1
        remainingSeconds = currentStep.seconds
        return false
    }
}
