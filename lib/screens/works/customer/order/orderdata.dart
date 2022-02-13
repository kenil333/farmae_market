import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class OrderData extends StatefulWidget {
  final OrderMarkedMy marked;
  final int i;
  OrderData(this.marked, this.i);
  @override
  _OrderDataState createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .child(widget.marked.order[widget.i].id)
        .child('CustomerConfirm')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().orderdetail,
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
              widget.marked.name,
              '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
              '${widget.marked.day} ${DateFormat('dd/MM/yyyy').format(widget.marked.date)}',
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                children: [
                  Customized().perticularSeller(
                    size,
                    widget.marked.order[widget.i].sellername,
                    widget.marked.order[widget.i].orderid,
                  ),
                  Customized().sizedheight(size.height * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Safeword : ',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: ConstantValue().text,
                                ),
                              ),
                              Text(
                                widget.marked.order[widget.i].safeword,
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: ConstantValue().greene,
                                    fontWeight: FontWeight.bold),
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
                            if (_what == 'Just Order') {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02),
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<Back>(context, listen: false)
                                        .commingorconfirm(
                                      widget.marked.order[widget.i].id,
                                      'CustomerConfirm',
                                      'Comming',
                                      () {},
                                      (String error) {
                                        Customized().snak(error, context);
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.009,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ConstantValue().orange,
                                    ),
                                    child: Text(
                                      ConstantValue().commingsoon,
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: ConstantValue().white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Customized().sizedheight(size.height * 0.015),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: widget.marked.order[widget.i].product.length,
              itemBuilder: (context, i) => OrderDataProdStemp(
                ConstantValue().orderdetail,
                widget.marked.order[widget.i].product[i].name,
                widget.marked.order[widget.i].product[i].image,
                widget.marked.order[widget.i].product[i].price
                    .toStringAsFixed(2),
                widget.marked.order[widget.i].product[i].qty.toString(),
                widget.marked.order[widget.i].product[i].unit,
              ),
            ),
            Customized().sizedheight(size.height * 0.03),
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
                    return Customized().customButton(
                      size,
                      ConstantValue().confirmpicup,
                      ConstantValue().greene,
                      () {
                        Provider.of<Back>(context, listen: false)
                            .commingorconfirm(
                          widget.marked.order[widget.i].id,
                          'CustomerConfirm',
                          'Confirmed',
                          () {},
                          (String error) {
                            Customized().snak(error, context);
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
            Customized().sizedheight(size.height * 0.03),
            Customized().customButton(
              size,
              ConstantValue().missinggoods,
              ConstantValue().orange,
              () {
                Customized().naviagt(
                  context,
                  MissingGoods(widget.marked.order[widget.i]),
                );
              },
            ),
            Customized().sizedheight(size.height * 0.03),
            Customized().customButton(
              size,
              ConstantValue().retungood,
              ConstantValue().redi,
              () {
                Customized().naviagt(
                  context,
                  ReturnGoods(widget.marked.order[widget.i]),
                );
              },
            ),
            Customized().sizedheight(size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
