import 'package:flutter/material.dart';

import '../../../../all.dart';

class ReturnGoods extends StatelessWidget {
  final OrderCust order;
  ReturnGoods(this.order);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().retungood,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/CustomerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.015),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: order.product.length,
              itemBuilder: (context, i) => OrderDataProdStemp(
                ConstantValue().retungood,
                order.product[i].name,
                order.product[i].image,
                order.product[i].price.toStringAsFixed(2),
                order.product[i].qty.toString(),
                order.product[i].unit,
              ),
            ),
            Customized().sizedheight(size.height * 0.03),
            Customized().customButton(
              size,
              ConstantValue().askretunselctive,
              ConstantValue().greene,
              () {},
            ),
            Customized().sizedheight(size.height * 0.03),
            Customized().customButton(
              size,
              ConstantValue().cancle,
              ConstantValue().redi,
              () {},
            ),
            Customized().sizedheight(size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
