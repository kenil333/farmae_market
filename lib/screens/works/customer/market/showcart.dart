import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class ShowCartScreen extends StatefulWidget {
  final SellerCust seller;
  final OnlyOneMarkedCust marked;
  ShowCartScreen(this.seller, this.marked);

  @override
  _ShowCartScreenState createState() => _ShowCartScreenState();
}

class _ShowCartScreenState extends State<ShowCartScreen> {
  bool _queryrun = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Cart')
        .child(_phone)
        .child(widget.seller.phone)
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: ConstantValue().text,
        ),
        title: CartAppBar(widget.seller, _phone),
        backgroundColor: ConstantValue().background,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.03),
            child: InkWell(
              onTap: () {
                Navigator.of(context).popUntil(
                  ModalRoute.withName('/CustomerDashboard'),
                );
              },
              child: Icon(
                Icons.home_outlined,
                color: ConstantValue().text,
                size: size.width * 0.075,
              ),
            ),
          )
        ],
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
            List<CartProd> _cart = [];
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
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
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Customized().sizedheight(size.height * 0.01),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: _cart.length,
                                itemBuilder: (context, i) =>
                                    ConfirmOrderProdStemp(
                                  widget.seller,
                                  _cart[i],
                                  _phone,
                                ),
                              ),
                              Customized().sizedheight(size.height * 0.1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      child: Column(
                        children: [
                          _queryrun
                              ? Customized().loading()
                              : Customized().customButton(
                                  size,
                                  ConstantValue().confirmorder,
                                  ConstantValue().greene,
                                  () {
                                    setState(() {
                                      _queryrun = true;
                                    });
                                    if (_cart.isNotEmpty) {
                                      Provider.of<Back>(context, listen: false)
                                          .allowtoorder(
                                        _cart,
                                        () {
                                          Customized().naviagt(
                                            context,
                                            ConfirmOrder(_cart, widget.marked,
                                                widget.seller),
                                          );
                                          setState(() {
                                            _queryrun = false;
                                          });
                                        },
                                        (String print) {
                                          Customized().wrongdouble(
                                            print,
                                            'Tilgjengelig !',
                                            context,
                                            size,
                                          );
                                          setState(() {
                                            _queryrun = false;
                                          });
                                        },
                                      );
                                    } else {
                                      Customized().wrongDialog(
                                        ConstantValue().w20,
                                        context,
                                        size,
                                      );
                                      setState(() {
                                        _queryrun = false;
                                      });
                                    }
                                  },
                                ),
                          Customized().sizedheight(size.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Customized().datanot(size);
            }
          }
        },
      ),
    );
  }
}
