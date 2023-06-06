class MyUserModel {
  final String userId; // Unique userIdentifier for the user
  final String name; // User's full name
  final String email; // User's email address
  final String username; // User's username
  final String profilePicture; // URL to user's profile picture
  final String additionalDetails; // Additional details about the user
  final String phoneNumber; // User's phone number

  MyUserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePicture,
    required this.additionalDetails,
    required this.phoneNumber,
  });

  // Create a User from JSON data
  factory MyUserModel.fromJson(Map<String, dynamic> json) {
    return MyUserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      username: json[
          'useruserId'], // The key in the JSON data is 'useruserId', but it maps to the 'username' field in the User class
      profilePicture: json['profile_picture'],
      additionalDetails: json['additional_details'],
      phoneNumber: json['phone_number'],
    );
  }

  // Convert our User to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'useruserId':
          username, // The key in the JSON data is 'useruserId', but it maps to the 'username' field in the User class
      'profile_picture': profilePicture,
      'additional_details': additionalDetails,
      'phone_number': phoneNumber,
    };
  }
}
