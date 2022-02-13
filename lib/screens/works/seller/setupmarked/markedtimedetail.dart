import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../all.dart';

class MarkedTimeDetail extends StatelessWidget {
  final Datewithselandcust date;
  MarkedTimeDetail(this.date);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().markedinfo,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.02),
            Customized().timestemp(
              size,
              () {},
              '${date.day} ${DateFormat('dd/MM/yyyy').format(date.date)}',
            ),
            Customized().sizedheight(size.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${ConstantValue().seleger} : ',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: ConstantValue().text,
                  ),
                ),
                Text(
                  date.seller.length.toString(),
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: ConstantValue().text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Customized().sizedheight(size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${ConstantValue().kjopere} : ',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: ConstantValue().text,
                  ),
                ),
                Text(
                  date.customer.length.toString(),
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: ConstantValue().text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
