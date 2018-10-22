package com.example.flutterpgp;

import org.spongycastle.openpgp.PGPException;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterpgpPlugin implements MethodCallHandler {
    private static String METHOD_PGP_ENCRYPT = "pgpEncrypt";
    private static String METHOD_PGP_DECRYPT = "pgpDecrypt";
    private static String METHOD_AES_ECB_ENCRYPT = "aesEncrypt";
    private static String METHOD_AES_ECB_DECRYPT = "aesDecrypt";

    private static String ERROR_MESSAGE = "Invalid argument state";
    private static String GENERAL_ERROR_MESSAGE = "An error occured";

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterpgp");
        channel.setMethodCallHandler(new FlutterpgpPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        if (call.method.equals(METHOD_PGP_ENCRYPT)) {
            String rawText = call.argument("rawText");
            String publicKey = call.argument("publicKey");

            if (publicKey == null || publicKey.isEmpty() || rawText == null || rawText.isEmpty()) {
                result.error(ERROR_MESSAGE, null, null);
                return;
            }

            pgpEncrypt(rawText, publicKey, result);

        } else if (call.method.equals(METHOD_PGP_DECRYPT)) {
            String encryptedMessage = call.argument("encryptedMessage");
            String secureKey = call.argument("secureKey");
            String passPhrase = call.argument("passPhrase");

            if (encryptedMessage == null || encryptedMessage.isEmpty() || secureKey == null || secureKey.isEmpty()) {
                result.error(ERROR_MESSAGE, null, null);
                return;
            }

            pgpDecrypt(encryptedMessage, secureKey, passPhrase, result);
        } else if (call.method.equals(METHOD_AES_ECB_ENCRYPT)) {
            String rawText = call.argument("rawText");
            String passPhrase = call.argument("passPhrase");

            if (passPhrase == null || passPhrase.isEmpty() || rawText == null || rawText.isEmpty()) {
                result.error(ERROR_MESSAGE, null, null);
                return;
            }

            aesEncrypt(rawText, passPhrase, result);
        } else if (call.method.equals(METHOD_AES_ECB_DECRYPT)) {
            String encryptedMessage = call.argument("encryptedMessage");
            String passPhrase = call.argument("passPhrase");

            if (passPhrase == null || passPhrase.isEmpty() || encryptedMessage == null || encryptedMessage.isEmpty()) {
                result.error(ERROR_MESSAGE, null, null);
                return;
            }

            aesDecrypt(encryptedMessage,passPhrase,result);
        } else {
            result.notImplemented();
        }
    }

    private void pgpEncrypt(String message, String publicKey, Result result) {
        try {
            String encryptedMessage = PGPEncryption.encrypt(message, publicKey);
            result.success(encryptedMessage);
        } catch (IOException | PGPException e) {
            result.error(GENERAL_ERROR_MESSAGE, e.getMessage(), null);
        }
    }

    private void pgpDecrypt(String encryptedMessage, String secureKey, String passPhrase, Result result) {
        try {
            String decryptedMessage = PGPEncryption.decrypt(encryptedMessage, secureKey, passPhrase);
            result.success(decryptedMessage);
        } catch (Exception e) {
            result.error(GENERAL_ERROR_MESSAGE, e.getMessage(), null);
        }
    }

    private void aesEncrypt(String message, String passPhrase, Result result) {
        try {
            String encryptedMessage = AES_ECBEncryption.encrypt(message, passPhrase);
            result.success(encryptedMessage);
        } catch (Exception e) {
            result.error(GENERAL_ERROR_MESSAGE, e.getMessage(), null);
        }
    }

    private void aesDecrypt(String encryptedMessage, String passPhrase, Result result) {
        try {
            String decryptedMessage = AES_ECBEncryption.decrypt(encryptedMessage, passPhrase);
            result.success(decryptedMessage);
        } catch (Exception e) {
            result.error(GENERAL_ERROR_MESSAGE, e.getMessage(), null);
        }
    }
}
