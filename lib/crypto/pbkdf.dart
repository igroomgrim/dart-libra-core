import 'dart:typed_data';
import 'package:dart_libra_core/crypto/hmac_utils.dart';

class Pbkdf {
  Uint8List extract(Uint8List password, String salt, int iterations, int outputLen) {
    return Uint8List(8);
  }

  Uint8List pbkdf2(Uint8List password, Uint8List salt, int iterations, int outputLen) {
    const hmacLength = 32;
    final outputBuffer = Uint8List(outputLen);
    final hmacOutput = Uint8List(hmacLength);
    final block = Uint8List(salt.length + 4);
    final leftLength = (outputLen / hmacLength).ceil();
    final rightLength = outputLen - (leftLength - 1) * hmacLength;
    
    salt.asMap().forEach((index, value) => 
      block[index] = value
    );

    for (int i = 1; i <= leftLength; i++) {
      //// Warning note: Must! Find new solution for BigEdian, don't use tricky like this  
      //block.writeUInt32BE(i, salt.length);
      block[block.length-1] += 1;

      Uint8List hmac = HmacUtils.digestFromSHA3256Hmac(password, block);
      hmac.asMap().forEach((index, value) => 
        hmacOutput[index] = value
      );

      for (int j = 1; j < iterations; j++) {
        hmac = HmacUtils.digestFromSHA3256Hmac(password, hmac);
        for (int k = 0; k < hmacLength; k++) {
          // tslint:disable-next-line:no-bitwise
          hmacOutput[k] ^= hmac[k];
        }
      }
      
      final destPos = (i - 1) * hmacLength;
      final len = i == leftLength ? rightLength : hmacLength;

      for (int idx = destPos; idx < len; idx++) {
        outputBuffer[idx] = hmacOutput[idx];
      }
    }

    return outputBuffer;
  }
}