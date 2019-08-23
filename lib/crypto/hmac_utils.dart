import 'dart:typed_data';
import 'package:dart_libra_core/crypto/sha3.dart';

class HmacUtils {
  static Uint8List digestFromSHA3256Hmac(Uint8List key, Uint8List data) {
    const blockSize = 136;
    final ipad = Uint8List(blockSize);
    final opad = Uint8List(blockSize);
    var tempKey = Uint8List(blockSize);

    if (key.length > blockSize) {
      final sha3 = SHA3256Digest(256);
      final temp = sha3.process(key);

      temp.asMap().forEach((index, _) => 
        tempKey[index] = temp[index]
      );

    } else if (key.length < blockSize) {
      key.asMap().forEach((index, _) => 
        tempKey[index] = key[index]
      );
    }

    for (int i = 0; i < blockSize; i++) {
      /* tslint:disable */
      ipad[i] = tempKey[i] ^ 0x36;
      opad[i] = tempKey[i] ^ 0x5C;
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