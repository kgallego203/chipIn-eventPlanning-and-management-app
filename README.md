# chip_in

chip_in is an event planning and management app powered by Flutter and Appwrite.

## Current Features
- Ability to sign up and log in
- Ability for a user to create an event
- Ability for a user to see the events they created
- Ability for all users to see all events available created by other users

## MVP Features (Still in progress)
User Stories & Flows: https://smoggy-look-b1d.notion.site/User-Stories-User-Flow-53005529ae1a4b65ab551761f9dfbc73

1. (Done) User Authentication: Allow users to register, log in, and log out of the app using Appwrite for authentication. Users can create an account, sign in with their credentials, and securely log out when they're done.

2. (Done) Event Creation: Provide users with the ability to create events within the app. Users can specify event details such as the title, date, time, location, and description, and save them to Appwrite's database.

3. (In Progress) Event Listing: Display a list of events to users, showcasing events created by other users. Users can browse through various events and view basic information about each event, such as the title and date. This feature allows users to discover and explore events created by the community.

4. Event Details: Enable users to view complete details of a selected event. Users can access information such as the event's description, location, date, time, and any additional details provided by the event creator. If the user is the event creator, they can also have the option to edit or delete the event.

5. Attendee Management: Provide functionality for managing event attendees. Users can view a list of attendees for a specific event, including their names or usernames. This feature allows event organizers to keep track of attendees and perform actions like adding or removing attendees as needed.

6. User Profile: Allow users to view and update their profile information. Users can access their profile, view their name and profile picture, and make changes such as updating their name or profile picture. This feature provides a personalized experience for users and allows them to manage their profile within the app.

7. Notifications: Implement a notification system to keep users informed about important updates and events. Users may receive notifications about upcoming events, changes in attendee status, or other relevant updates. This feature enhances user engagement and ensures users stay informed about the events they are interested in.


## Codebase Structure
chip_in/lib/
├── constants
│   ├── README.md
│   ├── appwrite_constants.dart
│   └── constants.dart
├── features
│   ├── README.md
│   ├── auth
│   │   ├── controller
│   │   │   └── auth_controller.dart
│   │   ├── models
│   │   │   └── user_model.dart
│   │   ├── services
│   │   │   └── auth_service.dart
│   │   └── view
│   │       ├── authentication_screen.dart
│   │       ├── login_view.dart
│   │       └── signup_view.dart
│   ├── events
│   │   ├── models
│   │   │   └── event_model.dart
│   │   ├── services
│   │   │   └── event_service.dart
│   │   ├── view
│   │   │   ├── attendee_list_screen.dart
│   │   │   ├── event_creation_screen.dart
│   │   │   ├── event_details_screen.dart
│   │   │   ├── events_joining_screen.dart
│   │   │   ├── my_created_events_screen.dart
│   │   │   └── my_joined_events_screen.dart
│   │   └── widgets
│   │       ├── attendee_item.dart
│   │       └── event_card.dart
│   ├── home
│   │   └── home_screen.dart
│   ├── notifications
│   │   ├── services
│   │   │   └── notification_service.dart
│   │   ├── view
│   │   │   └── notification_screen.dart
│   │   └── widgets
│   │       └── notification_card.dart
│   └── profile
│       ├── services
│       │   └── user_service.dart
│       ├── view
│       │   └── profile_screen.dart
│       └── widgets
│           └── profile_card.dart
├── main.dart
├── themes
│   ├── README.md
│   ├── app_theme.dart
│   ├── palette.dart
│   └── theme.dart
└── utils
    ├── README.md
    ├── form_utilities.dart
    └── validators.dart