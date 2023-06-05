# Features

This folder contains the main features of the event planning and management system.

## Auth

The `auth` feature handles user authentication and registration.

- `controller`: Contains the `AuthController` class, which handles user authentication and registration logic.
- `models`: Contains the `UserModel` class, which represents a user in the system.
- `services`: Contains the `AuthService` class, which provides methods for authenticating and registering users.
- `view`: Contains the UI components for the authentication and registration screens.

## Events

The `events` feature handles event creation, management, and joining.

- `models`: Contains the `EventModel` class, which represents an event in the system.
- `services`: Contains the `EventService` class, which provides methods for fetching and manipulating events in the Appwrite database.
- `view`: Contains the UI components for the event creation, details, and joining screens.
- `widgets`: Contains the UI components for displaying events and attendees.

## Home

The `home` feature is the main screen of the app.

- `home_screen.dart`: Contains the `HomeScreen` widget, which displays the main screen of the app.

## Notifications

The `notifications` feature handles notifications for events.

- `services`: Contains the `NotificationService` class, which provides methods for sending and receiving notifications.
- `view`: Contains the UI components for the notifications screen.
- `widgets`: Contains the UI components for displaying notifications.

## Profile

The `profile` feature handles user profiles.

- `services`: Contains the `UserService` class, which provides methods for fetching and updating user profiles.
- `view`: Contains the UI components for the user profile screen.
- `widgets`: Contains the UI components for displaying user profiles.