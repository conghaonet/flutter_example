/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuthDemo(),
    );
  }
}

class FirebaseAuthDemo extends StatefulWidget {
  @override
  _FirebaseAuthDemoState createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Example code of how to sign in with Github.
  Future<void> _signInWithGithub() async {
    final AuthCredential credential = GithubAuthProvider.getCredential(
      token: '2dadb48b3afde479de51d77584e8d4d0de16d537',
    );
    AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult?.user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      Fluttertoast.showToast(msg: 'Successfully signed in with Github. ' + user.uid);
    } else {
      Fluttertoast.showToast(msg: 'Failed to sign in with Github.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              try {
                GoogleSignInAccount account = await _googleSignIn.signIn();
                Fluttertoast.showToast(msg: account?.email ?? '登陆失败！');
              } catch (error) {
                print(error);
              }
            },
            child: Text('Google sing in',
            ),
          ),
          RaisedButton(
            onPressed: () async {
              try {
                await _googleSignIn.signOut();
                Fluttertoast.showToast(msg: 'Logout');
              } catch (error) {
                print(error);
              }
            },
            child: Text('Google sign out',
            ),
          ),
          RaisedButton(
            onPressed: () async {
              final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
              final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

              final AuthCredential credential = GoogleAuthProvider.getCredential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
              Fluttertoast.showToast(msg: "signed in " + user.displayName);
              print("signed in " + user.displayName);
            },
            child: Text('FirebaseAuth sing in',),
          ),
          RaisedButton(
            onPressed: () async {
              await _auth.signOut();
              Fluttertoast.showToast(msg: 'sing out');
            },
            child: Text('FirebaseAuth sing out',),
          ),
          RaisedButton(
            onPressed: () async {
              await _signInWithGithub();
              Fluttertoast.showToast(msg: 'GitHub sing in');
            },
            child: Text('GitHub sing in',),
          ),
        ],
      ),
    );
  }
}*/
