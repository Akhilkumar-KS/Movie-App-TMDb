# MovieApp

MovieApp is an iOS application developed in Swift that allows users to browse popular movies, view detailed information including trailers, search for movies, and manage their favorites. The app integrates with **The Movie Database (TMDb) API** to fetch movie data.

---

## Features

1. **Movies List (Home)**
   - Displays popular movies fetched from TMDb.
   - Each movie shows:
     - **Title**   
     - **Rating**  
     - **Poster**
   - Users can tap a movie to view detailed information.

2. **Movie Detail Page**
   - Displays detailed information about a movie including:
     - **Trailer** (video player)  
     - **Title**  
     - **Plot / Overview**  
     - **Genre(s)**  
     - **Cast**  
     - **Duration**  
     - **Rating**
   - Users can mark/unmark as favorite directly from this page.

3. **Search**
   - Search for movies by title directly from the home screen.
   - Real-time API search results displayed as the user types.

4. **Favorites**
   - Mark/unmark movies as favorites from both list and detail pages.
   - Favorites are persisted using `UserDefaults` and restored on app relaunch.
   - Favorites are visually indicated throughout the app.

---

## Libraries Used (via Swift Package Manager)

- **[Alamofire](https://github.com/Alamofire/Alamofire)** – Networking library to handle API requests.
- **[SwiftMessages](https://github.com/SwiftKickMobile/SwiftMessages)** – For displaying in-app notifications and messages.
- **[Loader](https://github.com/your-loader-package)** – Loading indicators for network requests.

> All libraries are integrated using **Swift Package Manager**, no manual installation required.

---

## Setup

1. Clone the repository:  
   ```bash
   git clone https://github.com/Akhilkumar-KS/Movie-App-TMDb.git
   cd Movie-App-TMDb

