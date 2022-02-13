import 'package:flutter/material.dart';

import './../../../all.dart';

class ButtonSellerScreen extends StatelessWidget {
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
            ConstantValue().becomeseller,
            ConstantValue().greene,
            () {
              Customized().naviagt(
                context,
                BecomeSellerScreen(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.1),
          Customized().customButton(
            size,
            ConstantValue().login,
            ConstantValue().orange,
            () {
              Customized().naviagt(
                context,
                LoginSeller(),
              );
            },
          ),
        ],
      ),
    );
  }
}
