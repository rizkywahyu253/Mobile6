class UserModel {
  final String id;
  final String? username;
  final String? avatarUrl;
  final DateTime createdAt;

  UserModel({
    required this.id,
    this.username,
    this.avatarUrl,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      avatarUrl: map['avatar_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}