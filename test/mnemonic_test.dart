import 'package:flutter_test/flutter_test.dart';
import 'package:dart_libra_core/wallet/mnemonic.dart';
import 'package:bip39/bip39.dart' as bip39;

void main() {
  group("Mnemonic", (){
    test("- Test to generate mnemonic phrase by auto generate", () {
      final mnemonic = Mnemonic();
      expect(bip39.validateMnemonic(mnemonic.toString()), true);
    });

    test("- Test to generate mnemonic phrase by words list", () {
      final mnemonicString = "lend arm arm addict trust release grid unlock exhibit surround deliver front link bean night dry tuna pledge expect net ankle process mammal great";
      final mnemonicWords = mnemonicString.split(' ');
      final mnemonic = Mnemonic(words: mnemonicWords);
      expect(mnemonic.toString(), mnemonicString);
    });
  });
}