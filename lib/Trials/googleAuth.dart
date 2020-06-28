import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class GoogleAuth extends StatefulWidget {
  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      print(account);
      setState(() {
        _currentUser = account;
      });
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();

      // print(_currentUser);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    print("Good Bye");
    await _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Google Auth"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
          child: _currentUser == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () => _handleSignIn(),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.redAccent,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentUser.photoUrl != null)
                      Image.network(_currentUser.photoUrl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Name:"), Text(_currentUser.displayName)],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Email:"), Text(_currentUser.email)],
                    ),
                    RaisedButton(
                      onPressed: () => _handleSignOut(),
                      child: Text(
                        "Logout from Google",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blueGrey,
                    )
                  ],
                )),
    );
  }
}
