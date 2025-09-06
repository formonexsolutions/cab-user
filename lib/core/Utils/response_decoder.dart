import 'dart:convert';

class ResponseDecoder {
  static bool useBase64 = false; // Dev phase me false rakho, prod me true kar do

  static String decode(String rawResponseBody) {
    if (useBase64) {
      return utf8.decode(base64.decode(rawResponseBody));
    } else {
      return rawResponseBody; // direct return
    }
  }
}
