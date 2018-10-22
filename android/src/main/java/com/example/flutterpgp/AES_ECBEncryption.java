package com.example.flutterpgp;

import android.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class AES_ECBEncryption {
    public static String encrypt(String message, String passPhrase) throws Exception {

        SecretKeySpec skeySpec = new SecretKeySpec(passPhrase.getBytes("UTF-8"), "AES");

        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");

        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

        byte[] encrypted = cipher.doFinal(message.getBytes());

        return Base64.encodeToString(encrypted,Base64.DEFAULT);
    }

    public static String decrypt(String encryptedMessage, String passPhrase) throws Exception {

        SecretKeySpec skeySpec = new SecretKeySpec(passPhrase.getBytes("UTF-8"), "AES");

        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");

        cipher.init(Cipher.DECRYPT_MODE, skeySpec);

        byte[] original = cipher.doFinal(Base64.decode(encryptedMessage.getBytes(),Base64.DEFAULT));

        return new String(original);

    }
}
