import 'package:flutter/material.dart';

import './../../../all.dart';

class AdminWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Customized().customButton(
          size,
          ConstantValue().setuparked,
          ConstantValue().bluli,
          () {
            Customized().naviagt(
              context,
              MarkedScreen(),
            );
          },
        ),
      ],
    );
  }
}
