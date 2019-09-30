import 'package:flutter/material.dart';
import 'package:fisilti_arayuz/services/authentication.dart';
import 'package:fisilti_arayuz/services/primary_button.dart';
import 'package:flutter/rendering.dart';


class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { login,
  register,
  forget }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  String _nick;


  // İlk açılacak form belirlendi
  FormMode _formMode = FormMode.login;
  bool _isIos;
  bool _isLoading;

  // İnputların doğru doldurulması kontrol edildi
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //Giriş yap veya kaydol 
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.login) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else if(_formMode == FormMode.forget) {
              await widget.auth.resetEmail(_email);
              _showResetPassDialog();
              print('E-postanıza sıfırlama linki gönderildi');
               } 
        else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _formMode == FormMode.login) {
          widget.onSignedIn();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }  


  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _moveToRegister() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.register;
    });
  }

  void _moveToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.login;
    });
  }
  void _moveToForget(){         //şifremi unuttum ekranı key aktifleştirilmesi
    _formKey.currentState.reset();
    _errorMessage= "";
    setState(() {
      _formMode = FormMode.forget;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Sosyal Fısıltı'),
          backgroundColor: Colors.purple.shade300,
          
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hesabınızı doğrulayın"),
          content: new Text("Doğrulama linki e-mail adresinize gönderildi. Lütfen onaylayın"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                _moveToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
   void _showResetPassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Şifre Sıfırlama"),
          content: new Text("Şifre sıfırlama linki başarılı şekilde e-postanıza gönderildi."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                _moveToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody(){
    return SingleChildScrollView(child: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: [
            new Card(
              child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(16.0),
                    child: new Form(
                        key: _formKey,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: logoAndErrorMes()+ usernameAndPassword() + submitWidgets() ,
                        )
                    )
                ),
              ])
            ),
          ]
        )
      ));
  }

  Widget _showErrorMessage() {    //hata ile karşılaşılması sonuc hatanın düzgün şekilde stringe çevrilip yazdırılması
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/images/kalpagac.png'),
        ),
      ),
    );
  }
   List<Widget> submitWidgets() {
    switch (_formMode) {
      case FormMode.login:
        return [
          new PrimaryButton(
            key: new Key('login'),
            text: 'Giriş',
            height: 44.0,
            onPressed: _validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-account'),
            child: new Text("Hesabın yok mu ? Kayıt Ol."),
            onPressed: _moveToRegister
          ),
           new FlatButton(
            key: new Key('forget'),
            child: new Text("şifrenimi unuttun? Sıfırla"),
            onPressed: _moveToForget
          ),
        ];
      case FormMode.register:
        return [
          new PrimaryButton(
            key: new Key('register'),
            text: 'Hesap oluştur',
            height: 44.0,
            onPressed: _validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-login'),
            child: new Text("Hesabın var mı? Giris yap."),
            onPressed: _moveToLogin
          ),
          new FlatButton(
            key: new Key('forget'),
            child: new Text("şifrenimi unuttun? Sıfırla"),
            onPressed: _moveToForget
          ),
        ];
        case FormMode.forget:
        return [
          new PrimaryButton(
            key: new Key('forget'),
            text: 'Şifre sıfırla',
            height: 44.0,
            onPressed: _validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-account'),
            child: new Text("Hesabın yok mu ? Kayıt Ol."),
            onPressed: _moveToRegister
          ),
          new FlatButton(
            key: new Key('need-login'),
            child: new Text("Hesabın var mı? Giris yap."),
            onPressed: _moveToLogin
          ),
        ];
    }
    return null;
  }
   List<Widget> logoAndErrorMes (){
    return [
      _showLogo(),
      _showErrorMessage()
    ];
  }
   List<Widget> usernameAndPassword() {   // girdi alanları
     if (_formMode == FormMode.forget) {
                      return [
              padded(child: new TextFormField(
                 key: new Key('email'),
                decoration: new InputDecoration(labelText: 'Email'),
                autofocus: false,
               autocorrect: false,
               validator: (value) => value.isEmpty ? 'Email alanı boş bırakılamaz.' : null,
              onSaved: (value) => _email = value,
                )),
              ];     
      } else if (_formMode == FormMode.register) { 
        return [
      padded(child: new TextFormField(   
        key: new Key('email'),
        decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Email alanı boş olamaz.' : null,
        onSaved: (val) => _email = val,
      )),
      padded(child: new TextFormField(
        key: new Key('password'),
        decoration: new InputDecoration(labelText: 'Şifre'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Şifre alanı boş olamaz.' : null,
        onSaved: (val) => _password = val,
      )),
        padded(child: new TextFormField(
        key: new Key('Nick'),
        decoration: new InputDecoration(labelText: 'Nick'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Nick alanı boş birakilamaz' : null,
        onSaved: (val) => _nick = val,
      )),
    ];
      } else {
    return [
      padded(child: new TextFormField(   
        key: new Key('email'),
        decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Email alanı boş olamaz.' : null,
        onSaved: (val) => _email = val,
      )),
      padded(child: new TextFormField(
        key: new Key('password'),
        decoration: new InputDecoration(labelText: 'Şifre'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Şifre alanı boş olamaz.' : null,
        onSaved: (val) => _password = val,
      )),
    ];
      }
  }
   Widget padded({Widget child}) {  //oluşturulacak girdi alanları için çevre düzenlemesi saglayacak method
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }


}
