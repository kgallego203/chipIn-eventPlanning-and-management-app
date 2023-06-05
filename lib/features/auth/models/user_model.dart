// * Unused for now
class User {
  final String id; // Unique identifier for the user
  final String name; // User's full name
  final String email; // User's email address
  final String username; // User's username
  final String profilePicture; // URL to user's profile picture
  final String additionalDetails; // Additional details about the user

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePicture,
    required this.additionalDetails,
  });

  // Create a User from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json[
          'userId'], // The key in the JSON data is 'userId', but it maps to the 'username' field in the User class
      profilePicture: json['profile_picture'],
      additionalDetails: json['additional_details'],
    );
  }

  // Convert our User to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userId':
          username, // The key in the JSON data is 'userId', but it maps to the 'username' field in the User class
      'profile_picture': profilePicture,
      'additional_details': additionalDetails,
    };
  }
}
