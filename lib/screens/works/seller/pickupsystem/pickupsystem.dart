import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class PickUpSystemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Orders')
        .orderByChild('S-Phone')
        .equalTo(_phone)
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().pickupsystem,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
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
              List<PicUpSeller> _marked = [];
              snap.data.snapshot.value.forEach(
                (key, value) {
                  if (_marked.isEmpty) {
                    List<OrderInPickup> _order = [];
                    _order.add(
                      OrderInPickup(
                        id: key,
                        orderid: value['ID'],
                        safeword: value['Safeword'],
                        custname: value['C-Name'],
                        product: (value['Products'] as List<dynamic>)
                            .map(
                              (e) => ProdinPickUp(
                                id: e['P-ID'],
                                name: e['P-Name'],
                                image: e['P-Image'],
                                price: double.parse(e['P-Price']),
                                qty: int.parse(e['P-Count']),
                              ),
                            )
                            .toList(),
                      ),
                    );
                    _marked.add(
                      PicUpSeller(
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
                            OrderInPickup(
                              id: key,
                              orderid: value['ID'],
                              safeword: value['Safeword'],
                              custname: value['C-Name'],
                              product: (value['Products'] as List<dynamic>)
                                  .map(
                                    (e) => ProdinPickUp(
                                      id: e['P-ID'],
                                      name: e['P-Name'],
                                      image: e['P-Image'],
                                      price: double.parse(e['P-Price']),
                                      qty: int.parse(e['P-Count']),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                    } else {
                      List<OrderInPickup> _order = [];
                      _order.add(
                        OrderInPickup(
                          id: key,
                          orderid: value['ID'],
                          safeword: value['Safeword'],
                          custname: value['C-Name'],
                          product: (value['Products'] as List<dynamic>)
                              .map(
                                (e) => ProdinPickUp(
                                  id: e['P-ID'],
                                  name: e['P-Name'],
                                  image: e['P-Image'],
                                  price: double.parse(e['P-Price']),
                                  qty: int.parse(e['P-Count']),
                                ),
                              )
                              .toList(),
                        ),
                      );
                      _marked.add(
                        PicUpSeller(
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
                    return a.date.compareTo(b.date);
                  },
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _marked.length,
                itemBuilder: (context, i) => Customized().marketStemp(
                  size,
                  () {
                    Customized().naviagt(
                      context,
                      PackageListScreen(_marked[i]),
                    );
                  },
                  _marked[i].name,
                  '${_marked[i].street}, ${_marked[i].postcode} ${_marked[i].city}',
                  '${_marked[i].day} ${DateFormat('dd/MM/yyyy').format(_marked[i].date)}',
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
