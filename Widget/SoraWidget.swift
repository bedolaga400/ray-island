import WidgetKit
import SwiftUI
import ActivityKit

@main
struct SoraBundle: WidgetBundle {
    var body: some Widget {
        SoraLiveActivity()
    }
}

struct SoraLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SoraAttributes.self) { context in
            HStack(spacing: 14) {
                SoraView(pose: context.state.pose, size: 44)
                PropView(pose: context.state.pose, size: 28)
                Text(soraCaption(context.state.pose)).font(.headline)
                Spacer()
            }
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    SoraView(pose: context.state.pose, size: 44)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    PropView(pose: context.state.pose, size: 28)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(soraCaption(context.state.pose)).font(.subheadline)
                }
            } compactLeading: {
                SoraView(pose: context.state.pose, size: 22)
            } compactTrailing: {
                PropView(pose: context.state.pose, size: 16)
            } minimal: {
                SoraView(pose: context.state.pose, size: 22)
            }
        }
    }
}
