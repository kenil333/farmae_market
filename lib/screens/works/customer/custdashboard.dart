import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './../../../all.dart';

class CustomerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Do you want to exit ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  ConstantValue().no,
                  style: TextStyle(color: ConstantValue().greene),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  ConstantValue().yes,
                  style: TextStyle(color: ConstantValue().greene),
                ),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: ConstantValue().background,
        endDrawer: EndAppDrawer(ConstantValue().customer),
        appBar: Customized().appBarwithdrawer(
          size,
          ConstantValue().appname,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Customized().customButton(
              size,
              ConstantValue().findmarket,
              ConstantValue().orange,
              () {
                Customized().naviagt(
                  context,
                  FindMarket(),
                );
              },
            ),
            Customized().sizedheight(size.height * 0.1),
            Customized().customButton(
              size,
              ConstantValue().myorder,
              ConstantValue().greene,
              () {
                Customized().naviagt(
                  context,
                  MyOrderCust(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
