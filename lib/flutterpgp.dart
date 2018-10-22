import 'dart:async';

import 'package:flutter/services.dart';

class Flutterpgp {
  static const MethodChannel _channel = const MethodChannel('flutterpgp');
  static String METHOD_PGP_ENCRYPT = "pgpEncrypt";
  static String METHOD_PGP_DECRYPT = "pgpDecrypt";
  static String METHOD_AES_ECB_ENCRYPT = "aesEncrypt";
  static String METHOD_AES_ECB_DECRYPT = "aesDecrypt";

  static Future<String> pgpEncrypt(String rawText, String publicKey) async {
    final String encryptedText =
        await _channel.invokeMethod(METHOD_PGP_ENCRYPT, {
      "rawText": rawText,
      "publicKey": publicKey,
    });
    return encryptedText;
  }

  static Future<String> pgpDecrypt(
      String encryptedMessage, String secureKey, String passPhrase) async {
    String decryptedText = await _channel.invokeMethod(METHOD_PGP_DECRYPT, {
      "encryptedMessage": encryptedMessage,
      "secureKey": secureKey,
      "passPhrase": passPhrase
    });
    return decryptedText;
  }

  static Future<String> aesEbcEncrypt(String rawText, String passPhrase) async {
    final String encryptedText =
        await _channel.invokeMethod(METHOD_AES_ECB_ENCRYPT, {
      "rawText": rawText,
      "passPhrase": passPhrase,
    });
    return encryptedText;
  }

  static Future<String> aesEbcDecrypt(
      String encryptedMessage, String passPhrase) async {
    final String encryptedText =
        await _channel.invokeMethod(METHOD_AES_ECB_DECRYPT, {
      "encryptedMessage": encryptedMessage,
      "passPhrase": passPhrase,
    });
    return encryptedText;
  }
}
