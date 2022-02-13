import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class MarkedInfoDetailScreen extends StatefulWidget {
  final String id;
  MarkedInfoDetailScreen(this.id);

  @override
  _MarkedInfoDetailScreenState createState() => _MarkedInfoDetailScreenState();
}

class _MarkedInfoDetailScreenState extends State<MarkedInfoDetailScreen> {
  List<Datewithselandcust> _dates = [];
  int _count = 0;
  bool _loading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).setupmarkedinfo(
          widget.id,
          (int count, List<Datewithselandcust> dat) {
            _dates = dat;
            _count = count;
            Timer(Duration(seconds: 1), () {
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
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Marked')
        .child(widget.id)
        .child('Sellers')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().markedinfo,
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
                  Customized().markedonlynameaddress(
                    size,
                    () {},
                  ),
                  StreamBuilder(
                    stream: api,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snap,
                    ) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Customized().loading();
                      } else {
                        if (snap.hasData &&
                            !snap.hasError &&
                            snap.data.snapshot.value != null) {
                          List<String> _sellers = [];
                          snap.data.snapshot.value.forEach(
                            (key, value) {
                              _sellers.add(key);
                            },
                          );
                          return Customized().totsalandanother(
                            size,
                            _sellers.length.toString(),
                            _count.toString(),
                          );
                        } else {
                          return Customized().totsalandanother(
                            size,
                            '0',
                            _count.toString(),
                          );
                        }
                      }
                    },
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  _dates.isNotEmpty
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _dates.length,
                          itemBuilder: (context, i) => Column(
                            children: [
                              Customized().timestemp(
                                size,
                                () {
                                  Customized().naviagt(
                                    context,
                                    MarkedTimeDetail(_dates[i]),
                                  );
                                },
                                '${_dates[i].day} ${DateFormat('dd/MM/yyyy').format(_dates[i].date)}',
                              ),
                              Customized().sizedheight(size.height * 0.02)
                            ],
                          ),
                        )
                      : Container(),
                  Customized().sizedheight(size.height * 0.02),
                ],
              ),
            ),
    );
  }
}
