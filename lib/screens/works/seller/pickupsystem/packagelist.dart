import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../all.dart';

class PackageListScreen extends StatelessWidget {
  final PicUpSeller marked;
  PackageListScreen(this.marked);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().packagelist,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().marketStemp(
              size,
              () {},
              marked.name,
              '${marked.street}, ${marked.postcode} ${marked.city}',
              '${marked.day} ${DateFormat('dd/MM/yyyy').format(marked.date)}',
            ),
            Customized().sizedheight(size.height * 0.02),
            Customized().customButton(
              size,
              ConstantValue().packagelist,
              ConstantValue().greene,
              () {},
            ),
            Customized().sizedheight(size.height * 0.035),
            Container(
              width: double.infinity,
              height: 1.5,
              color: ConstantValue().text,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: marked.order.length,
              itemBuilder: (context, i) => Container(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: PickUpWidget(
                  () {
                    Customized().naviagt(
                      context,
                      PackageDetailScreen(marked.order[i]),
                    );
                  },
                  marked.order[i],
                ),
              ),
            ),
            Customized().sizedheight(size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
