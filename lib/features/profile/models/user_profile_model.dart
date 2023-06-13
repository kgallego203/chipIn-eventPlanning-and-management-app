class UserProfileModel {
  final String name; // User's full name
  final String email; // User's email address
  final String userID; // Unique userIdentifier for the user
  final DateTime? dateOfBirth; // User's date of birth
  final String? phoneNumber; // User's phone number
  final String? profilePicture; // URL to user's profile picture
  final String? location; // User's location

  UserProfileModel({
    required this.name,
    required this.email,
    required this.userID,
    this.dateOfBirth,
    this.phoneNumber,
    this.profilePicture,
    this.location,
  });

  // Create a User from JSON data
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'],
      email: json['email'],
      userID: json['userId'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      location: json['location'],
    );
  }

  // Convert our User to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userId': userID,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'location': location,
    };
  }
}
