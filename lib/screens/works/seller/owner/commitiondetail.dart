import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class CommitionDetailScreen extends StatefulWidget {
  final MarkedInCommistion marked;
  final Function func;

  CommitionDetailScreen(
    this.marked,
    this.func,
  );

  @override
  _CommitionDetailScreenState createState() => _CommitionDetailScreenState();
}

class _CommitionDetailScreenState extends State<CommitionDetailScreen> {
  List<SellerInOwnerCommition> _seller = [];
  MarkedInCommistion? _mark;
  double _total = 0;
  bool _loading = true;

  bool _findsom(String phone) {
    int i = _mark!.sel.indexWhere((element) => element.phone == phone);

    return _mark!.sel[i].invoice;
  }

  void change(String phone, bool value) {
    int i = _mark!.sel.indexWhere((element) => element.phone == phone);
    _mark!.sel[i].invoice = value;
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        _mark = widget.marked;
        Provider.of<Back>(context, listen: false).markedkamani(
          widget.marked.id,
          widget.marked.date,
          (List<SellerInOwnerCommition> sel, double tot) {
            _seller = sel;
            _total = tot;
            Timer(
              Duration(seconds: 1),
              () {
                setState(() {
                  _loading = false;
                });
              },
            );
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
    final api =
        FirebaseDatabase.instance.reference().child('Commision').onValue;
    final adminapi = FirebaseDatabase.instance
        .reference()
        .child('Marked')
        .child(widget.marked.id)
        .child('CommitionFee')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        '${ConstantValue().commision} Detail',
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
                  Customized().marketStemp(
                    size,
                    () {},
                    _mark!.name,
                    '${_mark!.street}, ${_mark!.postcode} ${_mark!.city}',
                    '${_mark!.day} ${DateFormat('dd/MM/yyyy').format(_mark!.date)}',
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.004),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${ConstantValue().totalsales} :  ',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: ConstantValue().text,
                          ),
                        ),
                        Text(
                          'Kr ${_total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: size.width * 0.055,
                            color: ConstantValue().greene,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.004),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${ConstantValue().commision} :  ',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: ConstantValue().text,
                          ),
                        ),
                        StreamBuilder(
                          stream: api,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snap,
                          ) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Customized().pricefetch(size);
                            } else {
                              double com = 0;
                              if (snap.hasData &&
                                  !snap.hasError &&
                                  snap.data.snapshot.value != null) {
                                com = _total *
                                    (double.parse(snap.data.snapshot.value) /
                                        100);
                              }
                              return Text(
                                'Kr ${com.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: size.width * 0.055,
                                  color: ConstantValue().greene,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.004),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${ConstantValue().adminfees} :  ',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: ConstantValue().text,
                          ),
                        ),
                        StreamBuilder(
                          stream: adminapi,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snap,
                          ) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Customized().pricefetch(size);
                            } else {
                              double com = 0;
                              if (snap.hasData &&
                                  !snap.hasError &&
                                  snap.data.snapshot.value != null) {
                                com = _total *
                                    (double.parse(snap.data.snapshot.value) /
                                        100);
                              }
                              return Text(
                                'Kr ${com.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: size.width * 0.055,
                                  color: ConstantValue().greene,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.01),
                  _seller.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _seller.length,
                          itemBuilder: (context, i) {
                            return Customized().sellerstempcommition(
                              size,
                              () {
                                Customized().naviagt(
                                  context,
                                  CommitionInvoiceScreen(
                                    _mark!,
                                    _seller[i],
                                    _findsom,
                                    widget.func,
                                    change,
                                  ),
                                );
                              },
                              _seller[i].name,
                              _seller[i].total.toStringAsFixed(2),
                              _findsom(_seller[i].phone),
                            );
                          },
                        )
                      : Container(),
                  Customized().sizedheight(size.height * 0.02),
                ],
              ),
            ),
    );
  }
}
