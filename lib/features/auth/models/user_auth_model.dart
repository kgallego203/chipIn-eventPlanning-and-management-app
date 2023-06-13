// Never used atm
class UserAuthModel {
  final String name; // User's full name
  final String email; // User's email address
  final String username; // User's username

  UserAuthModel({
    required this.name,
    required this.email,
    required this.username,
  });

  // Create a User from JSON data
  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel(
      name: json['name'],
      email: json['email'],
      username: json['username'],
    );
  }

  // Convert our User to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
    };
  }
}
