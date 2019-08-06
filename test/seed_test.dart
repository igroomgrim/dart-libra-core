import 'package:flutter_test/flutter_test.dart';
import 'package:dart_libra_core/wallet/keyfactory.dart';


void main() {
  group("Seed", (){
    final mnemonicString = "lend arm arm addict trust release grid unlock exhibit surround deliver front link bean night dry tuna pledge expect net ankle process mammal great";
    final mnemonicWords = mnemonicString.split(' ');
    test("- Test to generate seed from mnemonic words", () {
      final seed = Seed.fromMnemonic(mnemonicWords);
      expect(seed, isNotNull);
    });
  });
}