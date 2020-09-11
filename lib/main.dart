import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home.v.dart';
import 'views/signin.v.dart';
import './utils/session.dart';

void main() {
  runApp(GetMaterialApp(
      title: 'Questionário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff4389fa),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper()));
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool> isAuthenticated() async {
    bool auth = await Session.isAuthenticated() ?? false;
    await Future.delayed(Duration(milliseconds: 2500), () {});

    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: this.isAuthenticated(),
      builder: (_, snapshot) {
        Widget ret;

        if (snapshot.connectionState == ConnectionState.waiting)
          ret = Center(child: CircularProgressIndicator());
        else if (snapshot.connectionState == ConnectionState.done) {
          ret = snapshot.data ? HomeView() : SignInView();
        }

        return ret;
      },
    ));
  }
}
