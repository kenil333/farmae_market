import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../all.dart';

class AddorRemove extends StatelessWidget {
  final SellerCust seller;
  final CustProd prod;
  final String phone;
  AddorRemove(this.seller, this.prod, this.phone);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Cart')
        .child(phone)
        .child(seller.phone)
        .child(prod.id)
        .onValue;
    return StreamBuilder(
      stream: api,
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snap,
      ) {
        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          int _count = 0;
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            _count = snap.data.snapshot.value['Count'];
            return Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<Back>(context, listen: false).addorremovecart(
                        phone,
                        seller.phone,
                        prod.id,
                        prod.price,
                        _count,
                        false,
                      );
                    },
                    child: Icon(
                      Icons.remove_circle,
                      size: size.width * 0.075,
                      color: ConstantValue().greene,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.012,
                    ),
                    child: Text(
                      '$_count',
                      style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: ConstantValue().greene,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<Back>(context, listen: false).addorremovecart(
                        phone,
                        seller.phone,
                        prod.id,
                        prod.price,
                        _count,
                        true,
                      );
                    },
                    child: Icon(
                      Icons.add_circle,
                      size: size.width * 0.075,
                      color: ConstantValue().greene,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: InkWell(
                onTap: () {
                  Provider.of<Back>(context, listen: false).addorremovecart(
                    phone,
                    seller.phone,
                    prod.id,
                    prod.price,
                    _count,
                    true,
                  );
                },
                child: Icon(
                  Icons.add_circle,
                  size: size.width * 0.075,
                  color: ConstantValue().greene,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
