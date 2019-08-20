import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_libra_core/crypto/sha3.dart';
import 'package:dart_libra_core/utils/helper.dart';

void main() {
  group("SHA-3/256", (){
    final input = utf8.encode('Lorem ipsum dolor sit amet, consectetur adipiscing elit...');
    final expectedDigest = "25f888a9cb41602e79e57584614e93d250c598348af94e2f7d3143293664bf6c";
    test("- Test to generate hash from SHA-3/256 function", () {
        final sha3256 = SHA3256Digest(256);
        final output = sha3256.process(input);
        expect(createHexStringFromBytes(output), equals(expectedDigest));
    });
  });

  // Note : Reference expected digest result from https://emn178.github.io/online-tools/sha3_256.html
}