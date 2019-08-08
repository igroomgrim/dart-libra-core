import 'dart:typed_data';

class Hkdf {
  String _hasAlgorithm;

  Hkdf(String hashAlgorithm) {
    this._hasAlgorithm = hashAlgorithm;
  }

  Uint8List extract(Uint8List ikm, String salt) {

  }

  Uint8List expand(Uint8List prk, StringBuffer info, int outputLen) {

  }

  int hashLength() {
    
  }
}