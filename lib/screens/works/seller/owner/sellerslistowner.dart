import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class SellersListinOwner extends StatefulWidget {
  @override
  _SellersListinOwnerState createState() => _SellersListinOwnerState();
}

class _SellersListinOwnerState extends State<SellersListinOwner> {
  TextEditingController _search = TextEditingController();
  List<SellerInOwner> _seller = [];
  bool _loading = true;

  void _change(
    String id,
    String company,
    String org,
    String email,
    String street,
    String city,
    String postcode,
  ) {
    int i = _seller.indexWhere((element) => element.phone == id);
    _seller[i].company = company;
    _seller[i].org = org;
    _seller[i].email = email;
    _seller[i].street = street;
    _seller[i].city = city;
    _seller[i].postcode = postcode;
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).sellerforowner(
          ConstantValue().seller,
          'S-Phone',
          (List<SellerInOwner> seller) {
            setState(() {
              _seller = seller;
            });
            Timer(Duration(seconds: 2), () {
              setState(() {
                _loading = false;
              });
            });
          },
          () {
            setState(() {
              _loading = false;
            });
          },
          (String error) {
            Customized().snak(error, context);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().sellers,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Customized().sizedheight(size.height * 0.01),
                  Customized().searchwidget(
                    size,
                    'Search',
                    _search,
                    () {},
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  _seller.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _seller.length,
                          itemBuilder: (context, i) =>
                              Customized().selernameandkam(
                            size,
                            () {
                              Customized().naviagt(
                                context,
                                SellerInfoDash(
                                  _seller[i],
                                  ConstantValue().seller,
                                  _change,
                                ),
                              );
                            },
                            _seller[i].company,
                            _seller[i].total.toStringAsFixed(2),
                          ),
                        )
                      : Customized().datanot(size),
                  Customized().sizedheight(size.height * 0.02),
                ],
              ),
            ),
    );
  }
}
