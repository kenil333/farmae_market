import 'package:flutter/material.dart';

import '../../../../all.dart';

class OrderConfirmationPrompt extends StatelessWidget {
  final SellerCust seller;
  final String id;
  OrderConfirmationPrompt(this.seller, this.id);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil(
          ModalRoute.withName('/CustomerDashboard'),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: ConstantValue().background,
        //endDrawer: EndAppDrawer(),
        appBar: Customized().appBarforlimit(
          size,
          ConstantValue().orderplased,
          () {
            Navigator.of(context).popUntil(
              ModalRoute.withName('/CustomerDashboard'),
            );
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.05),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        ConstantValue().thankfororder,
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.06,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Customized().sellernameimage(
                      size,
                      () {},
                      seller.company,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.03),
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.05,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ConstantValue().white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: ConstantValue().text.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Ditt hentenr :',
                            style: TextStyle(
                              color: ConstantValue().text,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: Text(
                              '#$id',
                              style: TextStyle(
                                color: ConstantValue().text,
                                fontSize: size.width * 0.1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    alignment: Alignment.center,
                    child: Text(
                      'Vil du bestille fra andre selgere pa reko ringen ?',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: ConstantValue().text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.03),
                  Customized().customButton(
                    size,
                    ConstantValue().ordermore,
                    ConstantValue().greene,
                    () {
                      Navigator.of(context).popUntil(
                        ModalRoute.withName('/CustomerDashboard'),
                      );
                    },
                  ),
                  Customized().sizedheight(size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
