import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class CommitionsScreen extends StatefulWidget {
  @override
  _CommitionsScreenState createState() => _CommitionsScreenState();
}

class _CommitionsScreenState extends State<CommitionsScreen> {
  TextEditingController _commition = TextEditingController();
  List<MarkedInCommistion> _marked = [];
  bool _loading = true;

  bool _choosebool(MarkedInCommistion mark) {
    bool _invoice = true;
    if (mark.sel.isEmpty) {
      _invoice = false;
    } else {
      mark.sel.forEach(
        (e) {
          if (e.invoice == false) {
            _invoice = false;
          }
        },
      );
    }

    return _invoice;
  }

  void _changeinlist(String markedid, String phone, bool value) {
    int marki = _marked.indexWhere((element) => element.id == markedid);
    int _i = _marked[marki].sel.indexWhere((element) => element.phone == phone);
    _marked[marki].sel[_i].invoice = value;
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).comitionfetch(
          (List<MarkedInCommistion> mark) {
            _marked = mark;
            Timer(
              Duration(seconds: 1),
              () {
                setState(() {
                  _loading = false;
                });
              },
            );
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
    final commisionapi =
        FirebaseDatabase.instance.reference().child('Commision').onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().commision,
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.05,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: StreamBuilder(
                              stream: commisionapi,
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<dynamic> snap,
                              ) {
                                if (snap.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snap.hasData &&
                                    snap.data.snapshot.value != null) {
                                  String comm = snap.data.snapshot.value;
                                  return Text(
                                    '$comm %',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.07,
                                      color: ConstantValue().text,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    '0 %',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.07,
                                      color: ConstantValue().text,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Customized().valuewithdiolog(
                              context,
                              size,
                              ConstantValue().commision,
                              _commition,
                              () {
                                FocusScope.of(context).unfocus();
                                if (_commition.text.isEmpty) {
                                  Customized().wrongDialog(
                                    ConstantValue().w1,
                                    context,
                                    size,
                                  );
                                } else {
                                  Provider.of<Back>(context, listen: false)
                                      .ownercommition(
                                    _commition.text.trim(),
                                    () {
                                      _commition.text = '';
                                      Navigator.of(context).pop();
                                    },
                                    (error) {
                                      Customized().snak(error, context);
                                    },
                                  );
                                }
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.09,
                              vertical: size.height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: ConstantValue().greene,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              ConstantValue().change,
                              style: TextStyle(
                                color: ConstantValue().white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _marked.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _marked.length,
                          itemBuilder: (context, i) {
                            debugPrint("itemBuilder  ==>  ${_marked[i].date}    ${_marked[i].sel}");

                            return Customized().stempincommistion(
                              size,
                                  () {
                                Customized().naviagt(
                                  context,
                                  CommitionDetailScreen(
                                    _marked[i],
                                    _changeinlist,
                                  ),
                                );
                              },
                              _marked[i].name,
                              '${_marked[i].day} ${DateFormat('dd/MM/yyyy')
                                  .format(_marked[i].date)}',
                              _choosebool(_marked[i]),
                            );
                          },
                        )
                      : Customized().dnfsmall(size),
                  Customized().sizedheight(size.height * 0.02),
                ],
              ),
            ),
    );
  }
}
