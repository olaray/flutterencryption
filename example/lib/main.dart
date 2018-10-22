import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterpgp/flutterpgp.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // encryptText("Olaray");
    // doDecrypt();
    aesEncrypt("Good boy", "The guy is walking around the bu");
  }

  Future<void> doDecrypt() async {
    String encryptedMessage =
        await DefaultAssetBundle.of(context).loadString("assets/enc.sec");
    // print(encryptedMessage);

    String secureKey =
        await DefaultAssetBundle.of(context).loadString("assets/private.key");
    // print(secureKey);
    pgpDecrypt(encryptedMessage, secureKey, "");
  }

  Future<void> pgpEncryptText(String message) async {
    String publicKey =
        await DefaultAssetBundle.of(context).loadString("assets/pub.key");
    try {
      String encrypted = await Flutterpgp.pgpEncrypt(message, publicKey);
      print("Response from plugin for decrypted message is......");
      print(encrypted);
    } catch (e) {
      print('Failed to get platform version.');
    }

    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  Future<void> pgpDecrypt(
      String encryptedMessage, String secureKey, String passPhrase) async {
    try {
      String decrypted =
          await Flutterpgp.pgpDecrypt(encryptedMessage, secureKey, passPhrase);
      print("Response from plugin is......");
      print(decrypted);
    } catch (e) {}
  }

  Future<void> aesEncrypt(String message, String passPhrase) async {
    String encrypted = await Flutterpgp.aesEbcEncrypt(message, passPhrase);
    print("Response from plugin is ");
    print(encrypted);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Welcome to PGP Encryption on: BOYA!'),
        ),
      ),
    );
  }
}
