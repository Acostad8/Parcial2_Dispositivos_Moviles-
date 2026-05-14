class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatar,
      
  });


    // Método para crear una instancia de UserModel
    // a partir de un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? 'no name',
      email: json['email'] ?? 'no email',
      role: json['role'] ?? 'no role',
      avatar: json['avatar'] ?? 'no avatar',
    );
  }
}
