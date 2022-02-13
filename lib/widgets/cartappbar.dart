import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../all.dart';

class CartAppBar extends StatelessWidget {
  final SellerCust seller;
  final String phone;
  CartAppBar(this.seller, this.phone);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Cart')
        .child(phone)
        .child(seller.phone)
        .onValue;
    return StreamBuilder(
      stream: api,
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snap,
      ) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Text(
            '0 Vare(r) - Kr 00.00',
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          List<double> _price = [];
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            double _tot = 0;
            snap.data.snapshot.value.forEach(
              (key, value) {
                _price.add(
                  double.parse(value['Price']),
                );
              },
            );
            _price.forEach(
              (e) {
                _tot += e;
              },
            );
            return Text(
              '${_price.length} Vare(r) - Kr ${_tot.toStringAsFixed(2)}',
              style: TextStyle(
                color: ConstantValue().text,
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return Text(
              '0 Vare(r) - Kr 00.00',
              style: TextStyle(
                color: ConstantValue().text,
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        }
      },
    );
  }
}
