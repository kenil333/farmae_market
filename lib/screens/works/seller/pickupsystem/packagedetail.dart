import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class PackageDetailScreen extends StatelessWidget {
  final OrderInPickup order;
  PackageDetailScreen(this.order);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .child(order.id)
        .child('SellerConfirm')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().packagedetail,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PickUpWidget(() {}, order),
            Customized().sizedheight(size.height * 0.02),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '${ConstantValue().name} : ',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.045,
                                ),
                              ),
                              Text(
                                order.custname,
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Customized().sizedheight(size.height * 0.005),
                          Row(
                            children: [
                              Text(
                                '${ConstantValue().safeword} : ',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.045,
                                ),
                              ),
                              Text(
                                order.safeword,
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: api,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snap,
                    ) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        String _what = snap.data.snapshot.value;
                        if (_what == 'Confirmed') {
                          return Container();
                        } else {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height * 0.04,
                            ),
                            child: InkWell(
                              onTap: () {
                                Provider.of<Back>(context, listen: false)
                                    .commingorconfirm(
                                  order.id,
                                  'SellerConfirm',
                                  'Confirmed',
                                  () {},
                                  (String error) {
                                    Customized().snak(error, context);
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01,
                                  horizontal: size.width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  color: ConstantValue().greene,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ConstantValue().pickedup,
                                  style: TextStyle(
                                    color: ConstantValue().white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: order.product.length,
              itemBuilder: (context, i) => Customized().inProdStockstemp(
                size,
                () {},
                true,
                order.product[i].name,
                order.product[i].price.toStringAsFixed(2),
                order.product[i].id,
                order.product[i].qty.toString(),
                order.product[i].image,
              ),
            ),
            Customized().sizedheight(size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
