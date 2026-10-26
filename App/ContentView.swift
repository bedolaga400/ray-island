import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activity: Activity<SoraAttributes>? = nil
    @State private var pose = "stare"
    @State private var message = "Сора меняет позу каждые 6 секунд, пока приложение открыто."
    private let poses = ["stare", "fanta", "cat", "music", "sleep", "wave"]
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            SoraView(pose: pose, size: 140)
            PropView(pose: pose, size: 40)
            Text(soraCaption(pose)).font(.title3)
            Button(activity == nil ? "Запустить Сору" : "Остановить") {
                if activity == nil { start() } else { stop() }
            }
            .buttonStyle(.borderedProminent)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 8) {
                ForEach(poses, id: \.self) { p in
                    Button(soraCaption(p)) { update(p) }
                        .buttonStyle(.bordered)
                }
            }
            Text(message).font(.footnote).foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .onReceive(timer) { _ in
            guard activity != nil else { return }
            let i = poses.firstIndex(of: pose) ?? 0
            update(poses[(i + 1) % poses.count])
        }
    }

    func start() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            message = "Live Activities выключены: Настройки → Sora → Live Activities."
            return
        }
        let content = ActivityContent(state: SoraAttributes.ContentState(pose: pose), staleDate: nil)
        activity = try? Activity.request(attributes: SoraAttributes(name: "Сора"),
                                         content: content, pushType: nil)
        if activity == nil { message = "Не удалось запустить. Нужен iPhone 14 Pro или новее." }
    }

    func update(_ p: String) {
        pose = p
        guard let a = activity else { return }
        Task {
            await a.update(ActivityContent(state: SoraAttributes.ContentState(pose: p), staleDate: nil))
        }
    }

    func stop() {
        guard let a = activity else { return }
        Task { await a.end(nil, dismissalPolicy: .immediate) }
        activity = nil
    }
}
