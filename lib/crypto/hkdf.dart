import 'dart:typed_data';
import 'package:dart_libra_core/crypto/hmac_utils.dart';

class Hkdf {
  Uint8List extract(Uint8List ikm, Uint8List salt) {
    final ikmBuffer = Uint8List.fromList(ikm);
    final saltBuffer = Uint8List.fromList(salt);
    final prk = _sha3_256Extract(ikmBuffer, saltBuffer);
    return prk;
  }

  Uint8List expand(Uint8List prk, Uint8List info, int outputLen) {
    final prkBuffer = Uint8List.fromList(prk);
    final okm = _sha3_256Expand(prkBuffer, outputLen, info);
    return okm;
  }

  Uint8List _sha3_256Extract(Uint8List ikm, Uint8List salt) {
    final bIkm = Uint8List.fromList(ikm);
    final bSalt = Uint8List.fromList(salt);
    final md = HmacUtils.digestFromSHA3256Hmac(bSalt, bIkm);
    return md;
  }

  Uint8List _sha3_256Expand(Uint8List prk, int length, Uint8List info) {
    final bInfo = Uint8List.fromList(info);
    final bPrk = Uint8List.fromList(prk);
    final infoLen = bInfo.length;
    final hashLen = 32;
    final steps = (length / hashLen).ceil();

    if (steps > 0xFF) {
      throw StateError("OKM length $length is too long for sha3-256 hash");
    }

    // use single buffer with unnecessary create/copy/move operations
    final t = Uint8List(hashLen * steps + infoLen + 1);
    int start = 0;
    int end = 0;
    
    for (int c = 1; c <= steps; ++c) {
      // add info
      bInfo.asMap().forEach((index, value) => 
        t[index] = bInfo[index]
      );
      // add counter
      t[end + infoLen] = c;

      final output = HmacUtils.digestFromSHA3256Hmac(bPrk, t.sublist(start, end + infoLen + 1));
      output.asMap().forEach((index, value) => 
        t[index] = output[index]
      );

      start = end; // used for T(C-1) start
      end += hashLen; // used for T(C-1) end & overall end
    }
    
    return t.sublist(0, length);
  }
}