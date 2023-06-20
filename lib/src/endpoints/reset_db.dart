import 'package:shelf/shelf.dart';

import '../users.dart';

Response resetDB() {
  print('Cleared ${users.length} users');
  users.clear();
  return Response.ok('All users removed');
}
