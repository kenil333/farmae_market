import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class MarkedDateScreen extends StatefulWidget {
  final String id;
  MarkedDateScreen(this.id);
  @override
  _MarkedDateScreenState createState() => _MarkedDateScreenState();
}

class _MarkedDateScreenState extends State<MarkedDateScreen> {
  TextEditingController _maxseller = TextEditingController();
  DateTime? _date;
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Marked')
        .child(widget.id)
        .child('DateSeller')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().markeddate,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().maxseller,
              _maxseller,
            ),
            Customized().sizedheight(size.height * 0.05),
            Customized().datechooserow(
              size,
              _date == null
                  ? 'Choose Date'
                  : DateFormat('dd.MM.yyyy').format(_date!),
              () {
                Customized().datepicker(
                  context,
                  (DateTime? value) {
                    setState(() {
                      _date = value;
                    });
                  },
                  'Reg',
                );
              },
              () {
                setState(() {
                  _queryrun = true;
                });
                FocusScope.of(context).unfocus();
                if (_maxseller.text.isEmpty) {
                  Customized().wrongDialog(
                    ConstantValue().w2,
                    context,
                    size,
                  );
                  setState(() {
                    _queryrun = false;
                  });
                } else {
                  if (_date == null) {
                    Customized().wrongDialog(
                      ConstantValue().w3,
                      context,
                      size,
                    );
                    setState(() {
                      _queryrun = false;
                    });
                  } else {
                    Provider.of<Back>(context, listen: false).setdatesallers(
                      widget.id,
                      _maxseller.text.trim(),
                      DateFormat('yyyyMMdd').format(_date ?? DateTime.now()),
                      DateFormat('EEEE').format(_date ?? DateTime.now()),
                      () {
                        setState(() {
                          _queryrun = false;
                          _maxseller.text = '';
                          _date = null;
                        });
                      },
                      (String error) {
                        Customized().snak(error, context);
                      },
                    );
                  }
                }
              },
              _queryrun,
            ),
            Customized().sizedheight(size.height * 0.04),
            StreamBuilder(
              stream: api,
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snap,
              ) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Customized().loading(),
                  );
                } else {
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data.snapshot.value != null) {
                    Map data = snap.data.snapshot.value;
                    List<MarkedDates> _dateseller = [];
                    data.forEach(
                      (key, value) {
                        _dateseller.add(
                          MarkedDates(
                            date: DateTime.parse(key),
                            sellers: value['Sellers'],
                          ),
                        );
                      },
                    );
                    if (_dateseller.isNotEmpty) {
                      _dateseller.sort(
                        (a, b) {
                          return a.date.compareTo(b.date);
                        },
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _dateseller.length,
                      itemBuilder: (context, i) => Customized().markeddatelist(
                        size,
                        () {
                          Provider.of<Back>(context, listen: false)
                              .removedateseller(
                            widget.id,
                            DateFormat('yyyyMMdd').format(_dateseller[i].date),
                            (String error) {
                              Customized().snak(error, context);
                            },
                          );
                        },
                        DateFormat('dd.MM.yyyy').format(_dateseller[i].date),
                        _dateseller[i].sellers,
                      ),
                    );
                  } else {
                    return Customized().dnfsmall(size);
                  }
                }
              },
            ),
            Customized().sizedheight(size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
