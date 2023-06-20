
import 'package:random_string/random_string.dart';
import 'package:shelf/shelf.dart';

import '../user.dart';
import '../users.dart';

Response challenge() {
  final challenge = randomString(10);
  
  users.add(User(challenge));
  return Response.ok(challenge);
}
