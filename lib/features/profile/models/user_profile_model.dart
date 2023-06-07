class UserProfileModel {
  final String userId; // Unique userIdentifier for the user
  final String name; // User's full name
  final String email; // User's email address
  final String username; // User's username
  final DateTime dateOfBirth; // User's date of birth
  final String phoneNumber; // User's phone number
  final String profilePicture; // URL to user's profile picture
  final String location; // User's location

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.username,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.profilePicture,
    required this.location,
  });

  // Create a User from JSON data
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      location: json['location'],
    );
  }

  // Convert our User to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'username': username,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'location': location,
    };
  }
}
