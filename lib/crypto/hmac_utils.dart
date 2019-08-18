import 'dart:typed_data';
import 'package:dart_libra_core/crypto/sha3.dart';

class HmacUtils {
  static Uint8List digestFromSHA3256Hmac(Uint8List key, Uint8List data) {
    const blockSize = 136;
    final ipad = Uint8List(blockSize);
    final opad = Uint8List(blockSize);

    if (key.length > blockSize) {
      final sha3 = SHA3256Digest(256);
      key = sha3.process(key);
    } else if (key.length < blockSize) {
      key = Uint8List.fromList(key + Uint8List(128));
    }

    for (int i = 0; i < blockSize; i++) {
      /* tslint:disable */
      ipad[i] = key[i] ^ 0x36;
      opad[i] = key[i] ^ 0x5C;
      /* tslint:disable */
    }

    final sha3Digest1 = SHA3256Digest(256);
    sha3Digest1.update(ipad, 0, ipad.length);
    final messageDigest1 = sha3Digest1.process(data);

    final sha3Digest2 = SHA3256Digest(256);
    sha3Digest2.update(opad, 0, opad.length);
    final finalDigest = sha3Digest2.process(messageDigest1);
    
    return finalDigest;
  }
}