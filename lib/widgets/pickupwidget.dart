import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../all.dart';

class PickUpWidget extends StatefulWidget {
  final Function func;
  final OrderInPickup order;
  PickUpWidget(this.func, this.order);
  @override
  _PickUpWidgetState createState() => _PickUpWidgetState();
}

class _PickUpWidgetState extends State<PickUpWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final custapi = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .child(widget.order.id)
        .child('CustomerConfirm')
        .onValue;
    final sellapi = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .child(widget.order.id)
        .child('SellerConfirm')
        .onValue;
    return InkWell(
      onTap: () {
        widget.func();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.03,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '#${widget.order.orderid}',
                  style: TextStyle(
                    fontSize: size.width * 0.09,
                    color: ConstantValue().text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  StreamBuilder(
                    stream: custapi,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snap,
                    ) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        String _what = snap.data.snapshot.value;
                        if (_what == 'Just Order') {
                          return Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: ConstantValue().white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ConstantValue().text,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Container(),
                          );
                        } else if (_what == 'Comming') {
                          return Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: ConstantValue().orange,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ConstantValue().text,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '!',
                              style: TextStyle(
                                color: ConstantValue().white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: ConstantValue().greene,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ConstantValue().text,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'V',
                              style: TextStyle(
                                color: ConstantValue().white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  Customized().sizedwidth(size.width * 0.05),
                  StreamBuilder(
                    stream: sellapi,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snap,
                    ) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        String _what = snap.data.snapshot.value;
                        if (_what == 'Just Order') {
                          return Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: ConstantValue().white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ConstantValue().text,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Container(),
                          );
                        } else {
                          return Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: ConstantValue().greene,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ConstantValue().text,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'V',
                              style: TextStyle(
                                color: ConstantValue().white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05,
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
          ],
        ),
      ),
    );
  }
}
