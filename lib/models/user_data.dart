class UserData {
  final String uid;
  final String displayName;
  final String roles;

  const UserData ({
    required this.uid,
    required this.displayName,
    required this.roles
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      uid: json['UID'].toString(),
      displayName: json['DisplayName'].toString(),
      roles: json['roles'].toString(),
    );
  }
}