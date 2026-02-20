# Thousand Counter 🃏

A mobile and web application for scoring the Eastern European card game **(Thousand)**. Built with Flutter, designed with full support for the game's complex rules including barrel mechanics, bolt penalties, and magic numbers.

---

## Screenshots

> //

---

## Features

- 🎮 **Full game management** — create games, track rounds, view history
- 👥 **Player profiles** — persistent profiles reusable across multiple games
- 📊 **Round history** — view and delete individual rounds with full replay logic
- 🌍 **Internationalization** — English and Russian
- 🌙 **Dark / Light / System theme**
- 📱 **iOS + Android + Web**

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x (Dart) |
| State Management | Riverpod |
| Database | Drift (SQLite) |
| Navigation | go_router |
| Localization | Flutter intl (ARB files) |
| Local Storage | shared_preferences |

### Architecture

The project follows **Clean Architecture** principles:

```
lib/
├── core/               # Constants, enums, validators, utilities
├── data/
│   ├── local/          # Database, SharedPreferences
│   ├── models/         # Drift table definitions
│   ├── repositories/   # Data access layer
│   ├── converters/     # Type converters for Drift
│   └── uow/            # Unit of Work pattern
├── models/             # Domain models (Game, Player, Profile, Round)
├── providers/          # Riverpod providers
├── services/           # Business logic (GameService, ProfileService, RulesService)
├── router/             # go_router configuration
└── ui/
    ├── screens/        # Full screens
    ├── widgets/        # Reusable widgets
    └── theme/          # Colors, text styles, theme extensions
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- For iOS: macOS with Xcode 14+
- For Android: Android Studio with Android SDK
- For Web: Chrome browser

### Installation

```bash
# Clone the repository
git clone https://github.com/SokolovG/Thousand-Counter.git
cd Thousand-Counter

# Install dependencies
flutter pub get

# Run code generation (Drift)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Running on specific platforms

```bash
# iOS (requires Mac + Xcode)
flutter run -d <device-id>

# Android
flutter run -d <device-id>

# Web
flutter run -d chrome

# Release build iOS
flutter run --release -d <device-id>
```

To find your device ID:
```bash
flutter devices
```

---

## Deployment

### iOS — Personal Device (Free)

No paid Apple Developer account required for personal use.

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select the `Runner` target → **Signing & Capabilities**
3. Set **Team** to your personal Apple ID
4. Connect iPhone via cable
5. Run:
```bash
flutter run --release -d <your-device-id>
```

> **Note:** With a free Apple ID, apps installed on your own device work indefinitely. Installing on someone else's device requires re-signing every 7 days.

### iOS — TestFlight (Paid)

Requires Apple Developer Program ($99/year). Allows distributing to others via TestFlight link without cable or re-signing.

### Android — APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

Share the APK file directly (e.g. via Telegram). Users enable "Install from unknown sources" in settings.

### Web

```bash
flutter build web --release
```

> **Important:** Drift uses `sqlite3.wasm` which requires specific HTTP headers:
> ```
> Cross-Origin-Opener-Policy: same-origin
> Cross-Origin-Embedder-Policy: require-corp
> ```
> GitHub Pages does **not** support custom headers. Use one of these instead:

**Cloudflare Pages** — add `_headers` file to `web/`:
```
/*
  Cross-Origin-Opener-Policy: same-origin
  Cross-Origin-Embedder-Policy: require-corp
```

**Netlify** — add `netlify.toml`:
```toml
[[headers]]
  for = "/*"
  [headers.values]
    Cross-Origin-Opener-Policy = "same-origin"
    Cross-Origin-Embedder-Policy = "require-corp"
```

---

## Database

The app uses **Drift** (SQLite wrapper) with the following schema:

```
Profiles     — persistent player identities (id, name)
Games        — game sessions (id, name, currentRound, isFinished, winner...)
Players      — game participants linking Profile to Game (points, bolts, barrel state...)
Rounds       — round history (playerScores as JSON, specialEvents as JSON)
```

Foreign key constraints:
- `Players.gameId` → `Games.id` (CASCADE delete)
- `Rounds.gameId` → `Games.id` (CASCADE delete)
- `Players.profileId` → `Profiles.id` (RESTRICT — profile cannot be deleted if used in games)

Current schema version: **2**

---

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit changes: `git commit -m "feat: your feature"`
4. Push: `git push origin feature/your-feature`
5. Open a Pull Request

---

## Roadmap

- [ ] Adaptive UI (Cupertino widgets on iOS)
- [ ] Round editing
- [ ] Cross-game statistics
- [ ] Sound effects

---

## License

MIT License — see [LICENSE](LICENSE) for details.