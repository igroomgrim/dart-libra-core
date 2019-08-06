import 'dart:typed_data';
import 'package:dart_libra_core/utils/helper.dart';
import 'package:dart_libra_core/wallet/mnemonic.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/digests/sha3.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:dart_libra_core/constants/keyprefixes.dart';
import 'package:pointycastle/pointycastle.dart';

class Seed {
  Uint8List _data;
  Uint8List get data => _data;

  static Seed fromMnemonic(List<String> words, {String salt = 'LIBRA'}) {
    // SHA-3/256/HMAC/PBKDF2
    // iterations: 2048
    // Output length: 32
    final mnemonic = Mnemonic(words: words);
    final sha3Digest = SHA3Digest(256);
    final params = Pbkdf2Parameters(createUint8ListFromString('$KeyPrefixes.MnemonicSalt$salt'), 2048, 32);
    final derivator = PBKDF2KeyDerivator(HMac(sha3Digest, 32));
    derivator.init(params);
    final data = derivator.process(mnemonic.toBytes());

    return Seed(data);
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
  }

  generateKey(int childDepth) {

  }
}