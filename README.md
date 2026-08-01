# 🎬 Cinex — Movie Discovery App

Cinex is a Flutter movie discovery app built as a freelancing portfolio project. It lets users browse trending and top-rated movies, search the full movie catalog, view detailed movie info with cast and trailers, filter by genre, and save personal favorites — all backed by real APIs and a clean, feature-based architecture.

## ✨ Features

- **Authentication** — Email/password signup & login, Google Sign-In, forgot password with OTP verification, powered by Firebase Auth REST APIs
- **Home** — Featured movie banner, Popular Movies, Last Month, and Last 6 Months sections, all pulling live data from TMDB
- **Movie Detail** — Poster, synopsis, genres, runtime, rating, full cast list, and an in-app embedded trailer player
- **Search** — Debounced live search across the TMDB movie catalog
- **Genres** — Browse and filter movies by genre and sort order
- **Favorites** — Save and remove favorite movies, persisted locally on-device
- **Bottom Navigation** — Curved animated navigation bar across Home, Favorites, Search, and Genres

## 🏗️ Architecture

The app follows a **feature-based MVC** structure — each feature (auth, movies) is self-contained with its own models, services, controllers, and views:

```
lib/
├── core/
│   └── constants/          # API endpoints, TMDB & Firebase config
├── features/
│   ├── auth/
│   │   ├── models/
│   │   ├── services/       # AuthService — Firebase REST API calls
│   │   ├── controllers/
│   │   └── views/
│   ├── movie_screens/
│   │   ├── models/         # MovieModel, MovieDetailModel, CastModel, VideoModel
│   │   ├── services/       # MovieService, FavoritesService
│   │   ├── controllers/    # GetX controllers per screen
│   │   ├── views/
│   │   └── nav_bar/
│   └── splash/
└── routes/                 # App routes & named page definitions
```

**State management:** [GetX](https://pub.dev/packages/get) — reactive controllers with individual `Rx` observables, simple `Get.put()` dependency injection (no bindings layer), and `Get.to()` navigation.

**Networking:** Plain `http` package with static service methods per feature — no repository abstraction layer, kept intentionally simple and consistent across Auth and Movies.

## 🔌 APIs Used

| API | Purpose |
|---|---|
| [Firebase Identity Toolkit](https://firebase.google.com/docs/reference/rest/auth) | Email/password auth, Google sign-in, password reset |
| [TMDB API](https://www.themoviedb.org/documentation/api) | Movie listings, search, details, cast/credits, trailers, genres |

## 📦 Packages

| Package | Purpose |
|---|---|
| `get` | State management, navigation, dependency injection |
| `flutter_screenutil` | Responsive UI scaling |
| `flutter_svg` | SVG asset rendering |
| `flutter_dotenv` | Environment variable management (API keys) |
| `http` | REST API networking |
| `get_storage` | Local persistent storage (session, favorites) |
| `google_sign_in` | Google authentication |
| `curved_navigation_bar` | Animated bottom navigation |
| `share_plus` | Native share sheet (share movies) |
| `youtube_player_iframe` | In-app embedded trailer playback |
| `cupertino_icons` | iOS-style icon set |

## 🔐 Environment Setup

Create a `.env` file in the project root with:

```
FIREBASE_API_KEY=your_firebase_web_api_key
TMDB_API_KEY=your_tmdb_api_key
```

## 🚀 Getting Started

```bash
flutter pub get
flutter run
```

Make sure your `.env` file is set up before running the app — both Auth and movie data depend on it.

## 📱 Screens

Splash → Onboarding → Login / Signup / Forgot Password / OTP Verification → Home → Movie Detail → Search → Genres → Favorites

---

Built with Flutter & GetX as part of an ongoing freelancing portfolio.
