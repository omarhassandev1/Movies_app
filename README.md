# Movies App

This is a movie browsing application built with Flutter.

## Screen Record

[Watch a screen record of the application](https://drive.google.com/file/d/1mgLbo_YfjEDQoCMDCWi1T8N3qgh72I_H/view?usp=sharing)

## Features

The application is divided into the following features:

### Onboarding

*   **Purpose**: To provide a welcoming and informative introduction for new users.
*   **How it works**:
    *   `get_started_screen.dart`: This is the Initial screen in the onboarding flow, featuring a "Get Started" button that navigates the user to the onboarding pages.
    *   `onboarding_screen.dart`: This is the main screen for the onboarding process. It likely displays a series of pages or a single page with information about the app's key features.
    *   `widgets/custom_outlined_button.dart`: A custom button widget used within the onboarding screens, likely for navigation between onboarding steps or to proceed to the main app.

### Authentication

*   **Purpose**: To manage user access to the application, including signing up new users, logging in existing users, and handling password recovery.
*   **How it works**:
    *   **Signup (`signup_screen.dart`)**: New users can create an account by providing necessary information. This screen also includes an `avatar_picker.dart` widget, allowing users to select a profile picture. The `AuthCubit` handles the registration logic, validates user input, and communicates with the backend.
    *   **Login (`login_screen.dart`)**: Existing users can sign in with their credentials. The `AuthCubit` manages the login process, including handling successful and failed login attempts.
    *   **Forget Password (UI only)**: This feature allows users to reset their password.

### Main Layer

This is the core of the application, accessible after a user successfully logs in. It's organized into a tabbed interface, with each tab representing a major feature.

*   #### Home

    *   **Purpose**: To provide a central hub for discovering movies.
    *   **How it works**:
        *   `home_tab.dart`: This is the main UI for the Home tab. It displays movies in various categories, such as "New Releases" and "Recommended".
        *   `category_movies.dart`: This screen is likely displayed when a user taps on a specific category, showing a full list of movies in that category.
        *   `bloc/home_bloc.dart`: This BLoC manages the state of the Home tab, fetching movie data from the backend and handling different states (loading, success, error).

*   #### Search

    *   **Purpose**: To allow users to find specific movies.
    *   **How it works**:
        *   `search_tab.dart`: The main UI for the Search tab. It contains a search bar and displays search results.
        *   `bloc/search_bloc.dart`: This BLoC handles the search logic. It takes user input, communicates with the backend to fetch search results, and updates the UI accordingly.

*   #### Profile

    *   **Purpose**: To provide a personalized space for the user, allowing them to manage their account and access app settings.
    *   **How it works**:
        *   `screens/profile_tab.dart`: The main UI for the Profile tab. It displays user information (like name and avatar) and provides navigation to sub-features.
        *   `cubit/profile_cubit.dart`: This Cubit manages the state of the Profile tab, such as fetching user data.
        *   **Sub-features**:
            *   **Favorites**:
                *   **Purpose**: To allow users to keep a list of their favorite movies.
                *   **How it works**: It has its own dedicated `cubit`, `view`, and `data` layers. Users can add or remove movies from their favorites list, and the `FavoritesCubit` updates the state, which is then reflected in the `favorites_screen.dart`.
            *   **History Service**:
                *   **Purpose**: To track and display the user's viewing history.
                *   **How it works**: This feature also follows a modular structure with its own `services`, `view`, and `cubit`. The `HistoryService` is responsible for logging the movies the user has watched, and the `HistoryCubit` retrieves this data to be displayed in the `history_screen.dart`.


*   #### Browse

    *   **Purpose**: To allow users to explore movies by different genres or categories.
    *   **How it works**:
    *   `browse_tab.dart`: This is the main UI for the Browse tab, which displays various movie categories in a visually appealing manner.

*   ### Movie Details

    *   **Purpose**: To provide detailed information about a selected movie.
    *   **How it works**:
        *   Displays comprehensive details for a specific movie, including its poster, title, description, and rating.
        *   `suggested_films_list.dart`: Includes a section that enhances the user experience by suggesting similar movies, encouraging further exploration.

## Project Structure

The project follows a feature-based structure, where each feature is organized into its own directory. A typical feature directory contains the following subdirectories:

*   **data**: Contains the business logic, models, repositories, and data sources for the feature.
*   **view**: Contains the UI components, such as screens and widgets.
*   **cubit** or **bloc**: Contains the state management logic for the feature.

This modular structure helps to keep the codebase organized and maintainable.
