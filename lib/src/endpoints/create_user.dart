import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../user.dart';
import '../users.dart';

Future<Response> createUser(Request request) async {
  final body = await request.readAsString();

  Map<String, dynamic> parsedJson = json.decode(body);

  String username = parsedJson['username'];

  var user = User(username);

  if (users.contains(user)) {
    return Response.forbidden(
        "A user with the username $username already exists");
  }

  users.add(User(username));
  print('Created user $username.');
  return Response.ok('Created user $username.');
}
