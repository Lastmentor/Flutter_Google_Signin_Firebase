import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_google_signin_example/Home%20Page.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        HomeDartPage.routeName:(BuildContext context) =>
        new HomeDartPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> signin() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    var _user = user;
    _signout();
    var route = new MaterialPageRoute(
      builder: (BuildContext context) =>
      new HomeDartPage(value: _user),
    );
    Navigator.of(context).push(route);
    return user;

  }

  void _signout(){
    googleSignIn.signOut();
    print("User Signed Out");
  }

  void giris(){
    final user = signin();
    if(user!=null){
      _girisSayfasi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: new ListView(
        children: <Widget>[
          new Padding(padding: const EdgeInsets.only(top: 30.0)),
          new Image(image: new AssetImage('images/plane.png'),width: 128.0,height: 128.0),
          new Padding(padding: const EdgeInsets.only(top: 10.0)),
          new Text(
            "Welcome to Air Reservation",
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan[600],
                fontSize: 20.0
            ),
                textAlign: TextAlign.center,
          ),
          new Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Container(
                  child: new DecoratedBox(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                      color: Colors.cyan[800],
                    ),
                    child: new ListTile(
                      leading: const Icon(Icons.email,color: Colors.white),
                      title: new TextField(
                        style: new TextStyle(color: Colors.white,fontSize: 18.0),
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: new TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new Container(
                  child: new DecoratedBox(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                      color: Colors.cyan[800],
                    ),
                    child: new ListTile(
                      leading: const Icon(Icons.lock,color: Colors.white,),
                      title: new TextField(
                        style: new TextStyle(color: Colors.white,fontSize: 18.0),
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                          hintStyle: new TextStyle(color: Colors.white),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new Container(
                  width: 100.0,
                  height: 50.0,
                  child: new RaisedButton(
                    onPressed: _alertDialog,
                    child: new Text("Sign In",style: new TextStyle(color: Colors.white,fontSize: 15.0)),
                    color: Colors.green[600],
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                    ),
                  ),
                ),
                new Padding(
                    padding: new EdgeInsets.only(top: 15.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text("CREATE ACCOUNT",style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color: Colors.cyan[600])),
                    new Text("FORGOT PASSWORD",style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color: Colors.cyan[600])),
                  ],
                ),

                new Divider(color: Colors.cyan[300],height: 30.0,),

                new Container(
                  width: 100.0,
                  height: 50.0,
                  child: new RaisedButton(
                    onPressed: giris,
                    child: new Text("Sign in With Google",style: new TextStyle(color: Colors.white),),
                    color: Colors.deepOrange[600],
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  void _girisSayfasi(){
    Navigator.of(context).pushNamed(HomeDartPage.routeName);
  }

  void _alertDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Oops! Something went wrong and we couldn't process your request. \n \n Try to sign in with Google \n \n :)",textAlign: TextAlign.center,),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK")),
      ],

    );
    showDialog(context: context, child: dialog);
  }

}

