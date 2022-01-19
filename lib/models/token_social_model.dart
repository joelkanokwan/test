import 'dart:convert';

class TokenSocialModel {
  final String token;
  final String nameSocial;
  final String avatarSocial;
  TokenSocialModel({
    required this.token,
    required this.nameSocial,
    required this.avatarSocial,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'nameSocial': nameSocial,
      'avatarSocial': avatarSocial,
    };
  }

  factory TokenSocialModel.fromMap(Map<String, dynamic> map) {
    return TokenSocialModel(
      token: map['token'] ?? '',
      nameSocial: map['nameSocial'] ?? '',
      avatarSocial: map['avatarSocial'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenSocialModel.fromJson(String source) => TokenSocialModel.fromMap(json.decode(source));
}
