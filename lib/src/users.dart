import 'user.dart';

List<User> users = List.empty(growable: true);

User? findUser(String username) {
  return users.isEmpty
      ? null
      : users.firstWhere((user) => user.username == username);
}
