# Bookify - Event Discovery & Booking App

 <img src="https://github.com/user-attachments/assets/42f10d18-9cff-4a47-9f22-00e521f90776" width="200"> 


A comprehensive, beautifully designed Flutter application to explore, discover, and book events near you. Built with Clean Architecture, Bloc/Cubit for State Management, and a focus on beautiful, modern UI.


## 📸 Screenshots

| Home | Events | Details | Profile | Search |
| :---: | :---: | :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/ad4c6204-94c1-449e-bd2c-39d46546cebd" width="180"> | <img src="https://github.com/user-attachments/assets/80ece1d3-1af9-4633-a85c-21e8edc50f7a" width="180"> | <img src="https://github.com/user-attachments/assets/410068a7-ae40-4234-bd94-e875e0c0c9a6" width="180"> | <img src="https://github.com/user-attachments/assets/a47663ba-e831-4110-b8e1-94b36c2cbf98" width="180"> | <img src="https://github.com/user-attachments/assets/51cea5b5-d1d3-4b0a-9832-65ca5fb26732" width="180"> |

| Sign In | Sign Up | Drawer |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/7742f3af-c011-4cc7-be8a-e96d02a87a53" width="180"> | <img src="https://github.com/user-attachments/assets/5b55841b-0240-458b-99f9-c32c4c580bc2" width="180"> | <img src="https://github.com/user-attachments/assets/631b780d-e02d-4ae0-bb27-029c793c4a88" width="180"> |

## ✨ Features

- **Authentication System:** Secure local sign-in and sign-up flows with "Remember Me" and saved account functionality.
- **Explore Events:** Discover nearby and upcoming events with dynamic categories.
- **Event Details & Booking:** Comprehensive details screen including header images, dates, locations, organizers, and ticket purchasing.
- **Favorites Management:** Easily save events to your profile for later viewing.
- **Advanced State Management:** Entirely powered by **Flutter Bloc (Cubit)** ensuring robust and decoupled business logic.
- **Dynamic UI/UX:**
  - Curved Navigation Bar with custom selected states.
  - Interactive "Advanced Drawer" for elegant navigation.
  - Shimmer effects for seamless loading states.
- **Local Caching & Storage:** Powered by SQLite, Shared Preferences, and Flutter Secure Storage.



## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit)
- **Networking:** [Dio](https://pub.dev/packages/dio)
- **Local Database:** [sqflite](https://pub.dev/packages/sqflite)
- **Secure Storage:** [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage), [shared_preferences](https://pub.dev/packages/shared_preferences)
- **UI Enhancements:** [shimmer](https://pub.dev/packages/shimmer), [flutter_advanced_drawer](https://pub.dev/packages/flutter_advanced_drawer)


## 📂 Project Structure

The project follows a modular **Feature-First / Clean Architecture** approach:

```text
lib/
├── Core/               # Constants, Themes, Utilities, and generic helpers
├── Data/               # Data Layer (Models, Repositories, Data Sources, SQLite Helpers)
│   ├── Models/
│   ├── data_source/
│   └── repository/
├── Presentation/       # UI Layer (Screens, Widgets, Cubits per feature)
│   ├── Auth/           # SignIn & SignUp flows with AuthCubit
│   ├── Events/         # Events list and Search with EventsCubit
│   ├── EventDetails/   # Event details logic with EventDetailsCubit
│   ├── Home/           # Main explorer with HomeCubit
│   ├── Profile/        # Organizer & User profile with ProfileCubit
│   ├── Splash/         
│   └── OnBoarding/
└── main.dart           # Entry point


## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.x.x)
- Android Studio / VS Code

### Installation

1. **Clone the repository:**
   git clone [https://github.com/Ahlamgomaa/Bookify]
   cd bookify


2. **Install dependencies:**
   flutter pub get
  

3. **Run the app:**
   flutter run
   


## 🏗 Architecture Details (State Management)

We extensively utilize **Cubit** (a subset of Bloc) to separate our business logic from the UI. Every major feature has its own independent manager:
- `AuthCubit`: Handles login, registration, and user sessions.
- `HomeCubit`: Orchestrates concurrent data fetching for upcoming and nearby events.
- `EventsCubit`: Manages the state of the general events list.
- `EventDetailsCubit`: Fetches specific event details without blocking the UI thread.
- `ProfileCubit`: Manages the user's localized favorite events.


Built by Ahlam Gomaa.
