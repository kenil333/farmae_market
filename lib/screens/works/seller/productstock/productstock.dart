import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class ProductStockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final phone = Provider.of<Back>(context, listen: false).me!.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Product')
        .orderByChild('AddedBy')
        .equalTo(phone)
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appbarwithicon(
        size,
        ConstantValue().productstock,
        () {
          Customized().naviagt(
            context,
            AddProduct(),
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
              Map data = snap.data.snapshot.value;
              List<Product> _products = [];
              data.forEach(
                (key, value) {
                  _products.add(
                    Product(
                      prodid: key,
                      addedby: value['AddedBy'],
                      imageurl: value['Image-URL'],
                      name: value['Name'],
                      price: double.parse(value['Price']),
                      available: int.parse(value['Available']),
                      tax: int.parse(value['Tax']),
                      qty: int.parse(value['Unit-Value']),
                      unit: value['Unit'],
                      tempzone: value['Temp-Zone'],
                      category: value['Category'],
                      description: value['Description'],
                      expiry: DateTime.parse(value['Expiry']),
                    ),
                  );
                },
              );
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Customized().sizedheight(size.height * 0.025),
                    Customized().customButton(
                      size,
                      ConstantValue().downloadproductlist,
                      ConstantValue().greene,
                      () {},
                    ),
                    Customized().sizedheight(size.height * 0.02),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _products.length,
                      itemBuilder: (context, i) =>
                          Customized().inProdStockstemp(
                        size,
                        () {
                          Customized().naviagt(
                            context,
                            UpdateProductScreen(_products[i]),
                          );
                        },
                        true,
                        _products[i].name,
                        _products[i].price.toStringAsFixed(2),
                        _products[i].prodid,
                        _products[i].available.toString(),
                        _products[i].imageurl,
                      ),
                    ),
                    Customized().sizedheight(size.height * 0.02),
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
