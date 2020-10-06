import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './utils/session.dart';
import 'containers/home/home.v.dart';
import 'containers/login/signin.v.dart';

void main() {
  runApp(GetMaterialApp(
      title: 'Questionário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1D76DF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper()));
}

class Wrapper extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_WrapperState>().restartApp();
  }

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Key key = UniqueKey();
  Future<bool> isAuthenticated() async {
    bool auth = await Session.isAuthenticated() ?? false;
    await Future.delayed(Duration(milliseconds: 2500), () {});

    return auth;
  }

  void restartApp() => setState(() => key = UniqueKey());

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: this.key,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: FutureBuilder(
            future: this.isAuthenticated(),
            builder: (_, snapshot) {
              Widget ret;

              if (snapshot.connectionState == ConnectionState.waiting)
                ret = Center(
                    child: Image.asset(
                  'assets/quiz-factory-inapp.png',
                  width: 125,
                ));
              else if (snapshot.connectionState == ConnectionState.done) {
                ret = snapshot.data ? HomeView() : SignInView();
              }

              return ret;
            },
          )),
    );
  }
}
