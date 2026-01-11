🎯 Flutter Battleships

A cross-platform Battleships game client built with Flutter that lets users register, log in, and play turn-based Battleship matches against other players or an AI opponent using a RESTful API backend. 
GitHub


🧠 Why This Project?

Battleships is a classic strategy game where each player places ships on a grid and takes turns firing at opponent positions. This Flutter implementation:

✔️ Shows practical use of Flutter for building a real interactive game UI
✔️ Demonstrates networking with a REST API backend
✔️ Includes user authentication, game logic, state management, and dynamic gameplay UI
✔️ Works on mobile, web, and desktop via Flutter’s cross-platform support 
GitHub

🧠 Features

Gameplay

User registration and login

Session token storage and persistence

View list of active and completed games

Place 5 ships on a 5x5 grid

Play shots against human or AI opponents

Display hits, misses, and sunk ships

Adaptive UI across screen sizes 
GitHub

Tech Highlights

Network requests with http package

Persistent storage with shared_preferences

State management with provider / FutureBuilder / StreamBuilder

Clean and responsive Flutter UI components 
GitHub

📦 Tech Stack
Layer	Technology
UI	Flutter (Dart)
State Management	Provider / Builders
Networking	http
Persistent Storage	shared_preferences
Platforms	Android • iOS • Web • Desktop
(based on repo file types and Flutter template) 
GitHub
	


🛠️ Getting Started
1. Clone the repo
git clone https://github.com/Kumbhkaran27/Flutter_Battleships.git
cd Flutter_Battleships

2. Install dependencies
flutter pub get

3. Run the app

Make sure a device/simulator/web server is running:

flutter run


⭐ You should see login screen → game list → board → interactive Battleships gameplay.

🛠️ Configuration

If the app uses environment variables or needs a backend URL, include an .env.example file and instructions here.

Example:

API_BASE_URL=https://your-backend-url.com

⚙️ How It Works

Authentication

User signs up or logs in

App stores session token locally

Token used for future API calls

Game Management

List all games (active or completed)

Create a new game with ship placements

Play turns via API updates

Gameplay UI

Ship placement screen

Turn display + hit/miss feedback
