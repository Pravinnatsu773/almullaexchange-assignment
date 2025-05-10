import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_bloc/flutter_bloc.dart';

// State class to hold encrypted/decrypted result
class EncryptionState {
  final String result;

  EncryptionState(this.result);
}

// Cubit class to manage the encryption/decryption logic
class EncryptionCubit extends Cubit<EncryptionState> {
  EncryptionCubit() : super(EncryptionState(''));

  // Encrypt the input text
  void encryptText(String text, String key) {
    final iv = encrypt.IV.fromSecureRandom(16);
    final encryptionKey = encrypt.Key.fromUtf8(_padKey(key));
    final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

    final encrypted = encrypter.encrypt(text, iv: iv);

    // Combine IV + encrypted text (base64 both)
    final combined = "${iv.base64}:${encrypted.base64}";
    emit(EncryptionState(combined));
  }

  // Decrypt the input text
  void decryptText(String combined, String key) {
    try {
      final parts = combined.split(':');
      if (parts.length != 2) throw Exception("Invalid format");

      final iv = encrypt.IV.fromBase64(parts[0]);
      final encryptedText = parts[1];
      final encryptionKey = encrypt.Key.fromUtf8(_padKey(key));
      final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

      final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
      emit(EncryptionState(decrypted));
    } catch (e) {
      emit(EncryptionState('Decryption failed: ${e.toString()}'));
    }
  }

  String _padKey(String key) => key.padRight(32).substring(0, 32);
}
