import 'package:flutter/material.dart';

import '../../../../all.dart';

class SaleOverButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().saloverview,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Customized().customButton(
            size,
            ConstantValue().invoice,
            ConstantValue().greene,
            () {
              Customized().naviagt(
                context,
                InvoiceScreen(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.06),
          Customized().customButton(
            size,
            ConstantValue().statistic,
            ConstantValue().orange,
            () {
              Customized().naviagt(
                context,
                StatisticScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
