

class LibraWallet {
  String mnemonic = "";
  String salt = "";

  LibraWallet({this.mnemonic, this.salt}) {
    this.mnemonic = this.mnemonic.isEmpty ? "gen mnemonic" : this.mnemonic;  
    // gen seed from mnemonic + salt
    // use KeyFactory gen pub, prv key from seed
  }
}