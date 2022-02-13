import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../all.dart';

class PosiButton extends StatelessWidget {
  final String phone;
  final SellerCust seller;
  final OnlyOneMarkedCust marked;
  PosiButton(this.phone, this.seller, this.marked);
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
          return Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: size.width,
              child: Customized().loading(),
            ),
          );
        } else {
          List<CartProd> _cart = [];
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            double _tot = 0;
            snap.data.snapshot.value.forEach(
              (key, value) {
                _cart.add(
                  CartProd(
                    id: key,
                    count: value['Count'],
                    price: double.parse(value['Price']),
                  ),
                );
              },
            );
            _cart.forEach(
              (e) {
                _tot += e.price;
              },
            );
            return Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                child: Column(
                  children: [
                    Customized().customButtonwithicon(
                      size,
                      '${_cart.length} Vare(r) - Kr ${_tot.toStringAsFixed(2)}',
                      ConstantValue().orange,
                      () {
                        Customized().naviagt(
                          context,
                          ShowCartScreen(
                            seller,
                            marked,
                          ),
                        );
                      },
                    ),
                    Customized().sizedheight(size.height * 0.02),
                  ],
                ),
              ),
            );
          } else {
            return Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                child: Column(
                  children: [
                    Customized().customButtonwithicon(
                      size,
                      '0 Vare(r) - Kr 00.00',
                      ConstantValue().orange,
                      () {
                        Customized().wrongDialog(
                          ConstantValue().w20,
                          context,
                          size,
                        );
                        // Customized().naviagt(
                        //   context,
                        //   ShowCartScreen(),
                        // );
                      },
                    ),
                    Customized().sizedheight(size.height * 0.02),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
