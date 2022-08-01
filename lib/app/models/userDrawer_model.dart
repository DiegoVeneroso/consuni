import 'dart:convert';

class UserDrawerModel {
  final int id;
  final String name;
  final String? imageAvatar;
  final bool representante;
  UserDrawerModel({
    required this.id,
    required this.name,
    this.imageAvatar,
    required this.representante,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageAvatar': imageAvatar,
      'representante': representante,
    };
  }

  factory UserDrawerModel.fromMap(Map<String, dynamic> map) {
    return UserDrawerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      imageAvatar: map['imageAvatar'],
      representante: map['representante'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDrawerModel.fromJson(String source) =>
      UserDrawerModel.fromMap(json.decode(source));
}
