import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './../../../all.dart';

class SellerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _who = Provider.of<Back>(context, listen: false).me!.who;
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
        endDrawer: EndAppDrawer(ConstantValue().seller),
        appBar: Customized().appBarwithdrawer(
          size,
          ConstantValue().appname,
        ),
        body: _who == ConstantValue().owner
            ? OwnerWidget()
            : _who == ConstantValue().seller
                ? SellerWidget()
                : AdminWidget(),
      ),
    );
  }
}
