import 'package:fido_server/src/endpoints/challenge.dart';
import 'package:fido_server/src/endpoints/create_user.dart';
import 'package:fido_server/src/endpoints/registration_request.dart';
import 'package:fido_server/src/endpoints/reset_db.dart';
import 'package:fido_server/src/read_file.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';

void main() async {
  final router = Router();
  _registerRoutes(router);

  // Define the request pipeline.
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(cookieParser())
      .addHandler(router);

  /// start the server.
  final server = await io.serve(handler, 'localhost', 8080);
  print('Server listening on ${server.address.host}:${server.port}');
}

void _registerRoutes(Router app) {
  // Creates an non-validated user
  app.post('/create-user', (Request request) async {
    return await createUser(request);
  });

  /// Called by the client to commence a FIDO registration
  app.post('/register-request', (request) => registerRequest(request));

  // Endpoint for providing a challenge
  app.get('/challenge', (Request request) {
    return challenge();
  });

  app.get('/.well-known/assetlinks.json', (Request request) {
    var links = readFileAsString(join('resources', 'assetlinks.json'));

    return Response.ok(links,
        headers: {'Content-Type': 'application/json; charset=utf-8'});
  });

  // Endpoint for accepting a public key
  app.post('/public-key', (Request request) async {
    final publicKey = await request.readAsString();
    // Do something with the received public key
    return Response.ok('Public key received.');
  });

  // Endpoint for accepting an encrypted version of the challenge
  app.post('/encrypted-challenge', (Request request) async {
    final encryptedChallenge = await request.readAsString();
    // Decrypt the encrypted challenge using the associated private key
    // Do something with the decrypted challenge
    return Response.ok('Encrypted challenge received and decrypted.');
  });

  /// delete all of the registered users and start a fresh.
  app.post('/resetDB', (Request request) async {
    return resetDB();
  });
}
