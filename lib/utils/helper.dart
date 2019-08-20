import 'dart:typed_data';

Uint8List createBytesFromString(String string) {
  var bytes = Uint8List(string.length);
  
  bytes.asMap().forEach((index, _) {
    bytes[index] = string.codeUnitAt(index);
  });

  return bytes;
}

String createHexStringFromBytes(Uint8List bytes) {
  return bytes.map((byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}