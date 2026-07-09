class UserModel {
  final String idToken;
  final String email;
  final String refreshToken;
  final String localId;

  UserModel({
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.localId,
  });

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'email': email,
      'refreshToken': refreshToken,
      'localId': localId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idToken: json['idToken'] ?? '',
      email: json['email'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      localId: json['localId'] ?? '',
    );
  }

}