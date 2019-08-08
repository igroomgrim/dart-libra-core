import 'dart:typed_data';

Uint8List createUint8ListFromString(String s) {
  var uintArray = Uint8List(s.length);
  
  uintArray.asMap().forEach((index, _) {
    uintArray[index] = s.codeUnitAt(index);
  });

  return uintArray;
}