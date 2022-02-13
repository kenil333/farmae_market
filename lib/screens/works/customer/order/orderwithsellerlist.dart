import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../all.dart';

class OrderWithSellerList extends StatelessWidget {
  final OrderMarkedMy marked;
  OrderWithSellerList(this.marked);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().myorder,
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
            Customized().ordertitle(
              size,
              marked.name,
              '${marked.street}, ${marked.postcode} ${marked.city}',
              '${marked.day} ${DateFormat('dd/MM/yyyy').format(marked.date)}',
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: marked.order.length,
              itemBuilder: (context, i) => Customized().orderwithsellerstemp(
                size,
                () {
                  Customized().naviagt(
                    context,
                    OrderData(
                      marked,
                      i,
                    ),
                  );
                },
                marked.order[i].sellername,
                marked.order[i].orderid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
