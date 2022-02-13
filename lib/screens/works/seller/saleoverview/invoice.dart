import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  DateTime? _start;
  DateTime? _end;
  String _filter = 'No';
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
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().invoice,
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
              List<InvoiceMarked> _marked = [];
              snap.data.snapshot.value.forEach(
                (key, value) {
                  if (_filter == 'F') {
                    if (DateTime.parse(value['M-Date']).isAfter(
                          _start!.subtract(
                            Duration(days: 1),
                          ),
                        ) &&
                        DateTime.parse(value['M-Date']).isBefore(
                          _end!.add(
                            Duration(days: 1),
                          ),
                        )) {
                      if (_marked.any(
                        (e) =>
                            e.id == value['M-ID'] &&
                            e.date == DateTime.parse(value['M-Date']),
                      )) {
                      } else {
                        _marked.add(
                          InvoiceMarked(
                            id: value['M-ID'],
                            name: value['M-Name'],
                            date: DateTime.parse(value['M-Date']),
                            day: value['M-Day'],
                            address:
                                '${value['M-Street']}, ${value['M-postcode']} ${value['M-City']}',
                          ),
                        );
                      }
                    }
                  } else {
                    if (_marked.any(
                      (e) =>
                          e.id == value['M-ID'] &&
                          e.date == DateTime.parse(value['M-Date']),
                    )) {
                    } else {
                      _marked.add(
                        InvoiceMarked(
                          id: value['M-ID'],
                          name: value['M-Name'],
                          date: DateTime.parse(value['M-Date']),
                          day: value['M-Day'],
                          address:
                              '${value['M-Street']}, ${value['M-postcode']} ${value['M-City']}',
                        ),
                      );
                    }
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
                    Customized().sizedheight(size.height * 0.04),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Customized().datepicstemp(
                            size,
                            _start == null
                                ? 'Starting'
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
                          ),
                          Customized().datepicstemp(
                            size,
                            _end == null
                                ? 'Ending'
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
                          ),
                        ],
                      ),
                    ),
                    Customized().sizedheight(size.height * 0.04),
                    Customized().customButton(
                      size,
                      ConstantValue().filter,
                      ConstantValue().greene,
                      () {
                        if (_start == null && _end == null) {
                          Customized().wrongDialog(
                            ConstantValue().w22,
                            context,
                            size,
                          );
                        } else {
                          if (_start!.isAfter(_end!)) {
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
                    ),
                    Customized().sizedheight(size.height * 0.03),
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
                                  MakeInvoiceSel(_marked[i]),
                                );
                              },
                              _marked[i].name,
                              _marked[i].address,
                              '${_marked[i].day} ${DateFormat('dd/MM/yyyy').format(_marked[i].date)}',
                            ),
                          )
                        : Column(
                            children: [
                              Customized().sizedheight(size.height * 0.04),
                              Customized().dnfsmall(size),
                            ],
                          ),
                    Customized().sizedheight(size.height * 0.03),
                  ],
                ),
              );
            } else {
              return Customized().dnfsmall(size);
            }
          }
        },
      ),
    );
  }
}
