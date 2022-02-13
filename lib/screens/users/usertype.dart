import 'package:flutter/material.dart';

import './../../all.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarOfScreens(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Customized().imagecenter(size.width * 0.5),
          Customized().sizedheight(size.height * 0.1),
          Customized().customButton(
            size,
            ConstantValue().customer,
            ConstantValue().greene,
            () {
              Customized().naviagtwithsetting(
                context,
                LoginCustScreen(),
                '/LoginForCustomer',
              );
            },
          ),
          Customized().sizedheight(size.height * 0.1),
          Customized().customButton(
            size,
            ConstantValue().seller,
            ConstantValue().redi,
            () {
              Customized().naviagtwithsetting(
                context,
                ButtonSellerScreen(),
                '/SellerButton',
              );
            },
          ),
        ],
      ),
    );
  }
}
