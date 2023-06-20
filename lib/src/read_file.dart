import 'dart:io';

Future<String> readFileAsString(String filePath) async {
  try {
    File file = File(filePath);
    return await file.readAsString();
  } catch (e) {
    print('Error reading file: $e');
    rethrow;
  }
}
