import 'package:flutter/material.dart';

import './../../all.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String instruct;
  final String who;
  OTPScreen(this.phone, this.instruct, this.who);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarOfScreens(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Customized().firstbadge(
              size,
              ConstantValue().otptitle,
              context,
            ),
            Customized().sizedheight(size.height * 0.1),
            Customized().otpfeild(size, context),
            Customized().sizedheight(size.height * 0.15),
            Customized().customButton(
              size,
              ConstantValue().consfirm,
              ConstantValue().greene,
              () {
                if (widget.instruct == ConstantValue().register) {
                  if (widget.who == ConstantValue().customer) {
                    Customized().navigatereplas(
                      context,
                      RegisterDetailCust(widget.phone),
                    );
                  } else {
                    Customized().navigatereplas(
                      context,
                      RegisterSellerScreen(widget.phone),
                    );
                  }
                } else {
                  Customized().navigatereplas(
                    context,
                    ChangePasswordScreen(
                      widget.phone,
                      widget.who,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
