import ActivityKit

struct SoraAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var pose: String
    }
    var name: String
}

func soraCaption(_ pose: String) -> String {
    switch pose {
    case "fanta": return "Пьёт фанту"
    case "cat": return "Гладит кота"
    case "music": return "Слушает музыку"
    case "sleep": return "Спит"
    case "wave": return "Робко машет"
    default: return "Смотрит в одну точку"
    }
}
