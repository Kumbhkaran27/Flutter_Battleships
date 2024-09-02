CS 442 MP4: Battleships
1. Overview
This project implements a Battleships game where users can register, log in, and play against both human and AI opponents. The application integrates with a provided RESTful API to manage user sessions, game states, and interactions.

2. Features
2.1 Authentication
Register: Create a new user account.
Login: Access existing accounts and receive a session token.
Session Management: Store and manage session tokens. Require re-login upon token expiration.
2.2 Game Management
Game List: View ongoing and completed games with details such as game ID, player usernames, and game status.
Game Creation: Start new games against human or AI opponents.
Game Deletion: Option to delete ongoing or matchmaking games.
2.3 Gameplay
Ship Placement: Place 5 ships on a 5x5 board before starting the game.
Game Board Display: Show ships, hits, misses, and sunk ships.
Game Interaction: Play shots, view results, and track game progress.
2.4 Responsiveness
Adaptive UI: Ensure the game board and interface scale appropriately across different screen sizes.
3. RESTful API Integration
3.1 Authentication Endpoints
POST /register: Register a new user.
POST /login: Log in an existing user.
3.2 Game Endpoints
GET /games: Retrieve all games for the user.
POST /games: Start a new game with specified ships and optionally an AI opponent.
GET /games/{game_id}: Get detailed information about a specific game.
PUT /games/{game_id}: Play a shot in the specified game.
DELETE /games/{game_id}: Cancel or forfeit a game.
4. Implementation
4.1 External Packages
http: For HTTP requests.
shared_preferences: For persistent storage of session tokens.
provider: For state management.
4.2 Code Structure
lib/views/: Contains UI components and screens.
lib/models/: Contains data models and API response handling.
lib/utils/: Contains utility functions and classes.
lib/main.dart: Entry point of the application.
4.3 Asynchronous Operations
Use FutureProvider, FutureBuilder, or StreamBuilder for handling asynchronous tasks.
Display loading indicators for operations that may take time.
