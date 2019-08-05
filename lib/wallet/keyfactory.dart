import 'dart:typed_data';

class Seed {
  Uint8List _data = Uint8List.fromList([]);
  Uint8List get data => _data;

  Seed fromMnemonic(List<String> words, {String salt = 'LIBRA'}) {
    //return Seed();
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
}