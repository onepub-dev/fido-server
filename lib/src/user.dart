class User {
  String username;
  String? challenge;
  String? publicKey;

  User(this.username);

  @override
  int get hashCode =>
      username.hashCode ^ challenge.hashCode ^ publicKey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          challenge == other.challenge &&
          publicKey == other.publicKey;
}
