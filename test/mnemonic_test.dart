import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_libra_core/wallet/mnemonic.dart';
import 'package:bip39/bip39.dart' as bip39;

void main() {
  group("Mnemonic", (){
    final mnemonicString = "lend arm arm addict trust release grid unlock exhibit surround deliver front link bean night dry tuna pledge expect net ankle process mammal great";
    final mnemonicWords = mnemonicString.split(' ');
    test("- Test to generate mnemonic phrase by auto generate", () {
      final mnemonic = Mnemonic();
      expect(bip39.validateMnemonic(mnemonic.toString()), true);
    });

    test("- Test to generate mnemonic phrase by words list", () {
      final mnemonic = Mnemonic(words: mnemonicWords);
      expect(mnemonic.toString(), mnemonicString);
    });

    test(" Test convert mnemonic string to bytes", () {
      final mnemonic = Mnemonic(words: mnemonicWords);
      final uintArray = Uint8List.fromList([108, 101, 110, 100, 32, 97, 114, 109, 32, 97, 114, 109, 32, 97, 100, 100, 105, 99, 116, 32, 116, 114, 117, 115, 116, 32, 114, 101, 108, 101, 97, 115, 101, 32, 103, 114, 105, 100, 32, 117, 110, 108, 111, 99, 107, 32, 101, 120, 104, 105, 98, 105, 116, 32, 115, 117, 114, 114, 111, 117, 110, 100, 32, 100, 101, 108, 105, 118, 101, 114, 32, 102, 114, 111, 110, 116, 32, 108, 105, 110, 107, 32, 98, 101, 97, 110, 32, 110, 105, 103, 104, 116, 32, 100, 114, 121, 32, 116, 117, 110, 97, 32, 112, 108, 101, 100, 103, 101, 32, 101, 120, 112, 101, 99, 116, 32, 110, 101, 116, 32, 97, 110, 107, 108, 101, 32, 112, 114, 111, 99, 101, 115, 115, 32, 109, 97, 109, 109, 97, 108, 32, 103, 114, 101, 97, 116]);
      expect(mnemonic.toBytes(), uintArray);
    });
  });
}