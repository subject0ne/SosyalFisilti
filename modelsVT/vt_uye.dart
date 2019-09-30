class UyeVt {
  int _id;
  String _ad;
  String _soyad;
  int _tel;
  String _mail;
  bool tip;

  dynamic _sifre;
  
  int get id => _id;

  set id(int value) {
    _id = value;
  }

	 String get ad => _ad;

  set ad(String value) {
    _ad = value;
  }

  String get soyad => _soyad;

  set soyad(String value) {
    _soyad = value;
  }

  int get tel => _tel;

  set tel(int value) {
    _tel = value;
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
  }
  	 bool getTip() => this.tip;
	

   void isTip(bool tip) =>	this.tip = tip;
	




  dynamic get sifre => _sifre;

  set sifre(dynamic value) {
    _sifre = value;
  }
  UyeVt();
  UyeVt.num_gir(this._tel, this._sifre); //numarayla giris
  UyeVt.mail_gir(this._mail, this._sifre); // mail ile giris
  UyeVt.profil(this._id,this._ad,this._soyad,this._sifre,this._mail,this._tel,this.tip,);

  Map<String, dynamic> toMap(){
    var map=Map<String, dynamic>();
    map['id'] = _id;
    map['ad'] = _ad;
    map['soyad'] = _soyad;
    map['sifre'] = _sifre;
    map['mail'] = _mail;
    map['tel'] = _tel;
    map['tip'] = tip;
    return map;
  }
  UyeVt.frommap(Map<String,dynamic>map){
    this._id=map['id'];
      this._ad=map['ad'];
      this._soyad=map['soyad'];
      this._sifre=map['sifre'];
      this._mail=map['mail'];
      this._tel=map['tel'];
      this.tip=map['tip'];
  }

  @override
  String toString() {
    
    return 'uyevt{_id: $_id, _sifre: $_sifre, ad:$_ad, soyad:$_soyad, mail:$_mail}';
  }
  

  
}