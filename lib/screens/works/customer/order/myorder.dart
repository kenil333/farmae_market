import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class MyOrderCust extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .orderByChild('C-ID')
        .equalTo(_phone)
        .onValue;
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
      body: StreamBuilder(
        stream: api,
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snap,
        ) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
              List<OrderMarkedMy> _marked = [];
              snap.data.snapshot.value.forEach(
                (key, value) {
                  if (_marked.isEmpty) {
                    List<OrderCust> _order = [];
                    _order.add(
                      OrderCust(
                        id: key,
                        orderid: value['ID'],
                        safeword: value['Safeword'],
                        sellerid: value['S-Phone'],
                        sellername: value['S-Name'],
                        product: (value['Products'] as List<dynamic>)
                            .map(
                              (e) => OrderProdCust(
                                id: e['P-ID'],
                                name: e['P-Name'],
                                image: e['P-Image'],
                                price: double.parse(e['P-Price']),
                                qty: int.parse(e['P-Count']),
                                unit: e['P-Unit'],
                              ),
                            )
                            .toList(),
                      ),
                    );
                    _marked.add(
                      OrderMarkedMy(
                        mid: value['M-ID'],
                        name: value['M-Name'],
                        street: value['M-Street'],
                        postcode: value['M-postcode'],
                        city: value['M-City'],
                        day: value['M-Day'],
                        date: DateTime.parse(value['M-Date']),
                        order: _order,
                      ),
                    );
                  } else {
                    bool _found = _marked.any(
                      (element) =>
                          element.date == DateTime.parse(value['M-Date']),
                    );
                    if (_found) {
                      int _i = _marked.indexWhere(
                        (element) =>
                            element.date == DateTime.parse(value['M-Date']) &&
                            element.mid == value['M-ID'],
                      );
                      _marked[_i].order.add(
                            OrderCust(
                              id: key,
                              orderid: value['ID'],
                              safeword: value['Safeword'],
                              sellerid: value['S-Phone'],
                              sellername: value['S-Name'],
                              product: (value['Products'] as List<dynamic>)
                                  .map(
                                    (e) => OrderProdCust(
                                      id: e['P-ID'],
                                      name: e['P-Name'],
                                      image: e['P-Image'],
                                      price: double.parse(e['P-Price']),
                                      qty: int.parse(e['P-Count']),
                                      unit: e['P-Unit'],
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                    } else {
                      List<OrderCust> _order = [];
                      _order.add(
                        OrderCust(
                          id: key,
                          orderid: value['ID'],
                          safeword: value['Safeword'],
                          sellerid: value['S-Phone'],
                          sellername: value['S-Name'],
                          product: (value['Products'] as List<dynamic>)
                              .map(
                                (e) => OrderProdCust(
                                  id: e['P-ID'],
                                  name: e['P-Name'],
                                  image: e['P-Image'],
                                  price: double.parse(e['P-Price']),
                                  qty: int.parse(e['P-Count']),
                                  unit: e['P-Unit'],
                                ),
                              )
                              .toList(),
                        ),
                      );
                      _marked.add(
                        OrderMarkedMy(
                          mid: value['M-ID'],
                          name: value['M-Name'],
                          street: value['M-Street'],
                          postcode: value['M-postcode'],
                          city: value['M-City'],
                          day: value['M-Day'],
                          date: DateTime.parse(value['M-Date']),
                          order: _order,
                        ),
                      );
                    }
                  }
                },
              );
              if (_marked.length > 1) {
                _marked.sort(
                  (a, b) {
                    return b.date.compareTo(a.date);
                  },
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Customized().sizedheight(size.height * 0.02),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: _marked.length,
                        itemBuilder: (context, i) => Customized().orderstemp(
                          size,
                          () {
                            Customized().naviagt(
                              context,
                              OrderWithSellerList(_marked[i]),
                            );
                          },
                          _marked[i].name,
                          '${_marked[i].day} ${DateFormat('dd/MM/yyyy').format(_marked[i].date)}',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Customized().datanot(size),
              );
            }
          }
        },
      ),
    );
  }
}
