import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class SellerInfoDash extends StatefulWidget {
  final SellerInOwner seller;
  final String who;
  final Function change;
  SellerInfoDash(this.seller, this.who, this.change);

  @override
  _SellerInfoDashState createState() => _SellerInfoDashState();
}

class _SellerInfoDashState extends State<SellerInfoDash> {
  bool _loading = true;
  String _company = '';
  String _org = '';
  String _email = '';
  String _street = '';
  String _city = '';
  String _postcode = '';

  void _childchange(
    String company,
    String org,
    String email,
    String street,
    String city,
    String postcode,
  ) {
    _company = company;
    _org = org;
    _email = email;
    _street = street;
    _city = city;
    _postcode = postcode;
    setState(() {});
  }

  @override
  void initState() {
    _company = widget.seller.company;
    _org = widget.seller.org;
    _email = widget.seller.email;
    _street = widget.seller.street;
    _city = widget.seller.city;
    _postcode = widget.seller.postcode;
    _loading = false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(widget.seller.phone)
        .child('Block')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        widget.who,
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
                  Customized().selernameandkam(
                    size,
                    () {},
                    _company,
                    widget.seller.total.toStringAsFixed(2),
                  ),
                  Customized().sizedheight(size.height * 0.06),
                  Customized().customButton(
                    size,
                    ConstantValue().editinfo,
                    ConstantValue().greene,
                    () {
                      Customized().naviagt(
                        context,
                        EditSellerInfo(
                          widget.seller.phone,
                          _company,
                          _org,
                          _email,
                          widget.seller.password,
                          _street,
                          _city,
                          _postcode,
                          widget.who,
                          widget.change,
                          _childchange,
                        ),
                      );
                    },
                  ),
                  Customized().sizedheight(size.height * 0.06),
                  Customized().customButton(
                    size,
                    ConstantValue().markets,
                    ConstantValue().orange,
                    () {
                      Customized().naviagt(
                        context,
                        MarketsOfSellers(widget.seller.marked),
                      );
                    },
                  ),
                  Customized().sizedheight(size.height * 0.06),
                  StreamBuilder(
                    stream: api,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snap,
                    ) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Customized().loading();
                      } else {
                        bool _block = snap.data.snapshot.value;
                        return Customized().customButton(
                          size,
                          _block
                              ? ConstantValue().unblock
                              : ConstantValue().block,
                          ConstantValue().redi,
                          () {
                            Provider.of<Back>(context, listen: false)
                                .blockunblock(
                              widget.seller.phone,
                              _block ? false : true,
                              () {
                                Customized().truediload(
                                  _block
                                      ? ConstantValue().t6
                                      : ConstantValue().t5,
                                  context,
                                  size,
                                );
                              },
                              (String error) {
                                Customized().snak(error, context);
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                  Customized().sizedheight(size.height * 0.06),
                ],
              ),
            ),
    );
  }
}
