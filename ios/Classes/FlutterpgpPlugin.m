#import "FlutterpgpPlugin.h"
// #import <CommonCrypto/CommonCryptor.h>
// #import <CommonCrypto/CommonKeyDerivation.h>

@implementation FlutterpgpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutterpgp"
            binaryMessenger:[registrar messenger]];
  FlutterpgpPlugin* instance = [[FlutterpgpPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"aesEncrypt" isEqualToString:call.method]){
    //   NSString *rawText = call.arguments[@"rawText"];
    //   NSString *passPhrase = call.arguments[@"passPhrase"];
      
    //   NSData* rawTextData = [rawText dataUsingEncoding:NSUTF8StringEncoding];
    //   NSData* passPhraseData = [passPhrase dataUsingEncoding:NSUTF8StringEncoding];
      
      // CCCryptorStatus ccStatus = kCCSuccess;
      // size_t          cryptBytes = 0;
      // NSMutableData   *dataOut    = [NSMutableData dataWithLength:rawTextData.length + kCCBlockSizeAES128];

      // ccStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, passPhraseData.bytes, kCCKeySizeAES256, 0, rawTextData.bytes, rawTextData.length, dataOut.mutableBytes, dataOut.length, &cryptBytes);
      
      // if (ccStatus != kCCSuccess) {
      //     NSLog(@"CCCrypt status.....................: %d", ccStatus);
      // }else{
      //   NSLog(@"CCCrypt status.....................: %d", ccStatus);
      // }
      // // NSLog(kCCSuccess);
      // // NSLog(dataOut);
      
      
      // dataOut.length = cryptBytes;
      // // NSLog(dataOut);
      // NSString* encrypted = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];

      // NSData* encryptedData = [object encryptDataWithAESECB:rawTextData key:passPhraseData error:nil]
    //   NSString* convertedString  = [[NSString alloc] initWithData:rawTextData encoding:NSUTF8StringEncoding];
    //   NSString* convertedString2  = [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    //   NSLog(@"%@::::::: %d", convertedString, convertedString2);
    //   result(@"Hey");
  }else {
    result(FlutterMethodNotImplemented);
  }

//   + (NSData *)encryptDataWithAESECB:(NSData *)data
//                               key:(NSData *) key
//                             error:(NSError **)error {

//     size_t outLength;

//     int cipherLen = (int)(data.length/kAlgorithmBlockSize + 1)*kAlgorithmBlockSize;
//     NSMutableData *cipherData = [NSMutableData dataWithLength:cipherLen];
//     NSData *newData = [self addPaddingBeforeEncryptWithAESECB:data];

//     CCCryptorStatus result = CCCrypt(kCCEncrypt, // operation
//                                      kAlgorithm, // Algorithm
//                                      kCCOptionECBMode, // Mode
//                                      key.bytes, // key
//                                      key.length, // keylength
//                                      0,// iv 
//                                      newData.bytes, // dataIn
//                                      newData.length, // dataInLength,
//                                      cipherData.mutableBytes, // dataOut
//                                      cipherData.length, // dataOutAvailable
//                                      &outLength); // dataOutMoved


//     if (result == kCCSuccess) {
//         cipherData.length = outLength;
//     }else {
//         if (error) {
//             *error = [NSError errorWithDomain:kRNCryptManagerErrorDomain code:result userInfo:nil];
//         }
//         return nil;
//     }
//     return cipherData;
// }
}
@end
