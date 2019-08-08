import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;
import 'package:dart_libra_core/constants/mnemonicwords.dart';
import 'package:dart_libra_core/utils/helper.dart';

class Mnemonic {
  List<String> _words;
  
  Mnemonic({List<String> words}) {
    if (words == null) {
      final mnemonic = bip39.generateMnemonic(strength: 256);
      this._words = mnemonic.split(' ');
      return;
    }

    if (words.length < 6 || words.length % 6 != 0) {
      throw StateError("Mnemonic must have a word count divisible with 6");
    }

    for (var word in MnemonicWords.words) {
      if (!MnemonicWords.words.contains(word)) {
        throw StateError("Mnemonic contains an unknown word");
      }
    }

    this._words = words;
  }

  String toString() {
    return this._words.join(' ');
  }

  Uint8List toBytes() {
    final wordsString = this.toString();
    return createUint8ListFromString(wordsString);
  }
 }