import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  DateTime? _start;
  DateTime? _end;
  String _filter = '7';
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
    final String _tstring = DateFormat('yyyyMMdd').format(DateTime.now());
    final DateTime _t = DateTime.parse(_tstring);
    _coustomLable(String title, Function func, Size size) {
      return InkWell(
        onTap: () {
          func();
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.28,
          decoration: BoxDecoration(
            color: title == ConstantValue().filter
                ? ConstantValue().orange
                : ConstantValue().white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 20,
                color: ConstantValue().text.withOpacity(0.23),
              ),
            ],
            border: Border.all(
              width: 1,
              color: ConstantValue().text,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
              color: title == ConstantValue().filter
                  ? ConstantValue().white
                  : ConstantValue().text,
            ),
            maxLines: 1,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().statistic,
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
              Map data = snap.data.snapshot.value;
              double _income = 0;
              List<StatasticProd> _product = [];
              data.forEach(
                (key, value) {
                  _income += double.parse(value['Total']);
                  if (_filter == '7') {
                    final DateTime _s = _t.subtract(Duration(days: 8));
                    final DateTime _e = _t.add(Duration(days: 1));
                    if (DateTime.parse(value['M-Date']).isAfter(_s) &&
                        DateTime.parse(value['M-Date']).isBefore(_e)) {
                      (value['Products'] as List<dynamic>).map(
                        (e) {
                          if (_product.any(
                            (element) => element.id == e['P-ID'],
                          )) {
                            int i = _product.indexWhere(
                              (element) => element.id == e['P-ID'],
                            );
                            _product[i].count += int.parse(e['P-Count']);
                          } else {
                            _product.add(
                              StatasticProd(
                                id: e['P-ID'],
                                name: e['P-Name'],
                                image: e['P-Image'],
                                price: double.parse(e['P-Price']),
                                count: int.parse(e['P-Count']),
                              ),
                            );
                          }
                        },
                      ).toList();
                    }
                  } else if (_filter == '30') {
                    final DateTime _s = _t.subtract(Duration(days: 31));
                    final DateTime _e = _t.add(Duration(days: 1));
                    if (DateTime.parse(value['M-Date']).isAfter(_s) &&
                        DateTime.parse(value['M-Date']).isBefore(_e)) {
                      (value['Products'] as List<dynamic>).map(
                        (e) {
                          if (_product.any(
                            (element) => element.id == e['P-ID'],
                          )) {
                            int i = _product.indexWhere(
                              (element) => element.id == e['P-ID'],
                            );
                            _product[i].count += int.parse(e['P-Count']);
                          } else {
                            _product.add(
                              StatasticProd(
                                id: e['P-ID'],
                                name: e['P-Name'],
                                image: e['P-Image'],
                                price: double.parse(e['P-Price']),
                                count: int.parse(e['P-Count']),
                              ),
                            );
                          }
                        },
                      ).toList();
                    }
                  } else if (_filter == '1') {
                    final DateTime _s = _t.subtract(Duration(days: 366));
                    final DateTime _e = _t.add(Duration(days: 1));
                    if (DateTime.parse(value['M-Date']).isAfter(_s) &&
                        DateTime.parse(value['M-Date']).isBefore(_e)) {
                      (value['Products'] as List<dynamic>).map(
                        (e) {
                          if (_product.any(
                            (element) => element.id == e['P-ID'],
                          )) {
                            int i = _product.indexWhere(
                              (element) => element.id == e['P-ID'],
                            );
                            _product[i].count += int.parse(e['P-Count']);
                          } else {
                            _product.add(
                              StatasticProd(
                                id: e['P-ID'],
                                name: e['P-Name'],
                                image: e['P-Image'],
                                price: double.parse(e['P-Price']),
                                count: int.parse(e['P-Count']),
                              ),
                            );
                          }
                        },
                      ).toList();
                    }
                  } else if (_filter == 'F') {
                    final DateTime _s = _start!.subtract(Duration(days: 1));
                    final DateTime _e = _end!.add(Duration(days: 1));
                    if (DateTime.parse(value['M-Date']).isAfter(_s) &&
                        DateTime.parse(value['M-Date']).isBefore(_e)) {
                      (value['Products'] as List<dynamic>).map(
                        (e) {
                          if (_product.any(
                            (element) => element.id == e['P-ID'],
                          )) {
                            int i = _product.indexWhere(
                              (element) => element.id == e['P-ID'],
                            );
                            _product[i].count += int.parse(e['P-Count']);
                          } else {
                            _product.add(
                              StatasticProd(
                                id: e['P-ID'],
                                name: e['P-Name'],
                                image: e['P-Image'],
                                price: double.parse(e['P-Price']),
                                count: int.parse(e['P-Count']),
                              ),
                            );
                          }
                        },
                      ).toList();
                    }
                  } else {
                    (value['Products'] as List<dynamic>).map(
                      (e) {
                        if (_product.any(
                          (element) => element.id == e['P-ID'],
                        )) {
                          int i = _product.indexWhere(
                            (element) => element.id == e['P-ID'],
                          );
                          _product[i].count += int.parse(e['P-Count']);
                        } else {
                          _product.add(
                            StatasticProd(
                              id: e['P-ID'],
                              name: e['P-Name'],
                              image: e['P-Image'],
                              price: double.parse(e['P-Price']),
                              count: int.parse(e['P-Count']),
                            ),
                          );
                        }
                      },
                    ).toList();
                  }
                },
              );
              if (_product.length > 1) {
                _product.sort(
                  (a, b) {
                    return b.count.compareTo(a.count);
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
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _coustomLable(
                            '7 Days',
                            () {
                              setState(() {
                                _filter = '7';
                              });
                            },
                            size,
                          ),
                          _coustomLable(
                            '30 Days',
                            () {
                              setState(() {
                                _filter = '30';
                              });
                            },
                            size,
                          ),
                          _coustomLable(
                            '1 Years',
                            () {
                              setState(() {
                                _filter = '1';
                              });
                            },
                            size,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      margin: EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _coustomLable(
                            _start == null
                                ? 'Start'
                                : DateFormat('dd.MM.yyyy').format(_start!),
                            () {
                              Customized().datepicker(
                                context,
                                (DateTime? value) {
                                  setState(() {
                                    _start = value;
                                  });
                                },
                                'Sta',
                              );
                            },
                            size,
                          ),
                          _coustomLable(
                            _end == null
                                ? 'End'
                                : DateFormat('dd.MM.yyyy').format(_end!),
                            () {
                              Customized().datepicker(
                                context,
                                (DateTime? value) {
                                  setState(() {
                                    _end = value;
                                  });
                                },
                                'Sta',
                              );
                            },
                            size,
                          ),
                          _coustomLable(
                            ConstantValue().filter,
                            () {
                              if (_start == null || _end == null) {
                                Customized().wrongDialog(
                                  ConstantValue().w22,
                                  context,
                                  size,
                                );
                              } else {
                                if (_start!.isAfter(_end ?? DateTime.now())) {
                                  Customized().wrongDialog(
                                    ConstantValue().w23,
                                    context,
                                    size,
                                  );
                                } else {
                                  setState(() {
                                    _filter = 'F';
                                  });
                                }
                              }
                            },
                            size,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.03),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ConstantValue().stattotal,
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.07,
                                ),
                              ),
                              Text(
                                'Kr ${_income.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: ConstantValue().greene,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.07,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.02),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            ConstantValue().tensaleprod,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: ConstantValue().text,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                        ),
                        _product.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount:
                                    _product.length > 10 ? 10 : _product.length,
                                itemBuilder: (context, i) =>
                                    Customized().inProdStockstemp(
                                  size,
                                  () {},
                                  false,
                                  _product[i].name,
                                  _product[i].price.toStringAsFixed(2),
                                  _product[i].id,
                                  _product[i].count.toString(),
                                  _product[i].image,
                                ),
                              )
                            : Customized().dnfsmall(size),
                        Customized().sizedheight(size.height * 0.02),
                      ],
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
