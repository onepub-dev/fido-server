import 'dart:convert';

import 'package:fido_server/src/relay_party.dart';
import 'package:random_string/random_string.dart';

import 'user.dart';

/// When we recieved a request to commence a registration we
/// need to send back a set of registration options.
class RegisterOptions {
  factory RegisterOptions.create(User user) {
    return RegisterOptions(
        relayPartyId: RelayParty.id,
        relayPartyName: RelayParty.name,
        userId: user.username,
        username: user.username,
        algoId: -7,
        challenge: generateChallenge());
  }
  RegisterOptions(
      {required this.relayPartyId,
      required this.relayPartyName,
      required this.userId,
      required this.username,
      required this.algoId,
      required this.challenge});

  String relayPartyId;
  String relayPartyName;
  String username;
  String userId;
  int algoId;
  String challenge;

  static String generateChallenge() {
    return randomString(16);
  }

  String asJson() {
    var response = <String, Object>{};

    response['rp'] = {'id': relayPartyId, 'name': relayPartyName};
    response['user'] = {'name': username, 'id': userId};
    response['pubKeyCredParams'] = [
      {'alg': algoId}
    ];
    response['challenge'] = challenge;

    return jsonEncode(response);
  }
}
