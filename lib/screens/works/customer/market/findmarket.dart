import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../all.dart';

class FindMarket extends StatefulWidget {
  @override
  _FindMarketState createState() => _FindMarketState();
}

class _FindMarketState extends State<FindMarket> {
  String? _filter = 'Show All';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Marked').onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().findmarket,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/CustomerDashboard'),
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
              List<OnlyOneMarkedCust> _marked = [];
              List<String> _cant = ['Show All'];
              data.forEach(
                (key, value) {
                  List<String> _category = ["Show All"];
                  if (value['Categories'] != null) {
                    value['Categories'].forEach(
                      (ck, cv) {
                        _category.add(cv['Name']);
                      },
                    );
                  }
                  if (value['DateSeller'] != null &&
                      value['FreeToJoin'] != null &&
                      value['Sellers'] != null) {
                    if (!_cant.contains(value['Country'])) {
                      _cant.add(value['Country']);
                    }
                    value['DateSeller'].forEach(
                      (ke, val) {
                        List<String> _seller = [];
                        String _datestring = DateFormat('yyyyMMdd').format(
                          DateTime.now().subtract(
                            Duration(days: 1),
                          ),
                        );
                        if (DateTime.parse(ke).isAfter(
                          DateTime.parse(_datestring),
                        )) {
                          value['Sellers'].forEach(
                            (k, v) {
                              v['Dates'].forEach(
                                (dk, dv) {
                                  if (dk == ke) {
                                    if (!_seller.contains(k)) {
                                      _seller.add(k);
                                    }
                                  }
                                },
                              );
                            },
                          );
                          _marked.add(
                            OnlyOneMarkedCust(
                              id: key,
                              name: value['Name'],
                              street: value['Street'],
                              city: value['City'],
                              postcode: value['PostCode'],
                              country: value['Country'],
                              date: DateTime.parse(ke),
                              day: val['Day'],
                              free: value['FreeToJoin'],
                              seller: _seller,
                              category: _category,
                            ),
                          );
                        }
                      },
                    );
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Customized().sizedheight(size.height * 0.02),
                    Customized().customdropdown(
                      size,
                      _filter,
                      (String? value) {
                        setState(() {
                          _filter = value;
                        });
                      },
                      _cant,
                      'Filter by Country',
                    ),
                    Customized().sizedheight(size.height * 0.01),
                    _marked.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _marked.length,
                            itemBuilder: (context, i) =>
                                Customized().marketStemp(
                              size,
                              () {
                                Customized().naviagt(
                                  context,
                                  MarketDetailScreen(_marked[i]),
                                );
                              },
                              _marked[i].name,
                              '${_marked[i].street}, ${_marked[i].postcode} ${_marked[i].city}',
                              '${_marked[i].day} ${DateFormat('dd/MM/yyyy').format(_marked[i].date)}',
                            ),
                          )
                        : Column(
                            children: [
                              Customized().sizedheight(size.height * 0.04),
                              Customized().dnfsmall(size),
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
