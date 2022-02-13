import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../all.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 1),
      () {
        Provider.of<Back>(context, listen: false).autologin(
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(
                  name: '/CustomerDashboard',
                ),
                builder: (context) => CustomerDashboard(),
              ),
            );
          },
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(
                  name: '/SellerDashboard',
                ),
                builder: (context) => SellerDashboard(),
              ),
            );
          },
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(name: '/UserType'),
                builder: (context) => UserType(),
              ),
            );
          },
          (String error) {
            Customized().snak(error, context);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarOfScreens(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Customized().imagecenter(size.width * 0.5),
          Customized().sizedheight(size.height * 0.15),
          Customized().loading(),
        ],
      ),
    );
  }
}
