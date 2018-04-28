import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin_example/main.dart';

class HomeDartPage extends StatefulWidget {

  final FirebaseUser value;

  static const String routeName = "/HomeDartPage";
  HomeDartPage({Key key,this.value}) : super(key:key);

  @override
  _HomeDartPageState createState() => new _HomeDartPageState();
}

class _HomeDartPageState extends State<HomeDartPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(
                  "${widget.value.displayName}",
                  style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                ),
                accountEmail: new Text(
                    "${widget.value.email}",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                currentAccountPicture: new GestureDetector(
                  onTap: null,
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(
                      "${widget.value.photoUrl}",
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://bilgibirikimi.net/wp-content/uploads/2012/04/izmir-saat-kulesi.jpg"
                      ),
                  ),
                ),
            )
          ],
        ),
      ),
      body: new Center(
        child: new RaisedButton(
            onPressed: _cikisYap,
            child: new Text("Sign Out",style: new TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  void _cikisYap(){
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) => new MyApp()));
  }
}

