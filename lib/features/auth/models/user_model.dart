class User {
  final String id;
  final String name;
  final String email;
  final String username;
  final String profilePicture;
  final String additionalDetails;

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
      username: json['userId'],
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
      'userId': username,
      'profile_picture': profilePicture,
      'additional_details': additionalDetails,
    };
  }
}
