import 'dart:typed_data';
import 'package:dart_libra_core/constants/keyprefixes.dart';
import 'package:dart_libra_core/crypto/pbkdf.dart';
import 'package:dart_libra_core/crypto/hkdf.dart';
import 'package:dart_libra_core/wallet/mnemonic.dart';
import 'package:dart_libra_core/utils/helper.dart';

class Seed {
  Uint8List _data;
  Uint8List get data => _data;

  static Seed fromMnemonic(List<String> words, {String salt = 'LIBRA'}) {
    // SHA-3/256/HMAC/PBKDF2
    // iterations: 2048
    // Output length: 32
    final mnemonic = Mnemonic(words: words);
    final saltBuffer = createBytesFromString('${KeyPrefixes.MnemonicSalt}$salt');
    final bytes = Pbkdf().pbkdf2(mnemonic.toBytes(), saltBuffer, 2048, 32);

    return Seed(bytes);
  }

  Seed(Uint8List data) {
    if (data.length != 32) {
      throw new StateError('Seed data length must be 32 bits');
    }

    this._data = data;
  }
}

class KeyFactory {
  Seed _seed;
  Seed get seed => _seed;
  Uint8List _masterPrk;
  Uint8List get masterPrk => _masterPrk;

  KeyFactory(Seed seed) {
    this._seed = seed;
    this._masterPrk = Hkdf().extract(seed.data, createBytesFromString(KeyPrefixes.MasterKeySalt));
  }

  generateKey(int childDepth) {
    // Generates a new key pair at the number position.
  }
}