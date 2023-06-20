import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';

import '../registration_options.dart';
import '../users.dart';

Future<Response> registerRequest(Request request) async {
  var cookies = request.context['cookies'] as CookieParser;

  var username = cookies.get('username');

  if (username == null) {
    throw UserException('A username cookie was expected but none was found');
  }

  var user = findUser(username.value);

  if (user == null) {
    throw UserException('Unkown username $username');
  }

  final body = await request.readAsString();

  Map<String, dynamic> parsedJson = json.decode(body);

  String attestation = parsedJson['attestation'];

  var authenticatorSelection = parsedJson['authenticatorSelection'];

  var authenticatorAttachment =
      authenticatorSelection['authenticatorAttachment'];
  var userVerification = authenticatorSelection['userVerification'];

  var options = RegisterOptions.create(user);

  return Response.ok(options.asJson());
}

class UserException extends FidoException {
  UserException(super.message);
}

class FidoException implements Exception {
  String message;
  FidoException(this.message);
}
