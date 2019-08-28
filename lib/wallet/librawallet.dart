import 'package:dart_libra_core/wallet/mnemonic.dart';
import 'package:dart_libra_core/wallet/keyfactory.dart';

class LibraWallet {
  String _mnemonic = "";
  String _salt = "";
  KeyFactory _keyFactory;

  LibraWallet({String mnemonic, String salt}) {
    this._mnemonic = (mnemonic == null || mnemonic.isEmpty) ? Mnemonic().toString() : mnemonic;  
    this._salt = (salt == null || salt.isEmpty) ? 'LIBRA' : salt;
    final seed = Seed.fromMnemonic(this._mnemonic.split(' '), salt: this._salt);
    this._keyFactory = KeyFactory(seed); 
  }
}