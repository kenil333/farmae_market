import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class MarketJoinSetScreen extends StatefulWidget {
  final FindMarkedClass marked;

  MarketJoinSetScreen(this.marked);

  @override
  _MarketJoinSetScreenState createState() => _MarketJoinSetScreenState();
}

class _MarketJoinSetScreenState extends State<MarketJoinSetScreen> {
  bool _yes = false;
  bool _no = false;
  List<DateAndDay> _date = [];
  bool _loading = true;
  bool _queryrun = false;

  @override
  void initState() {
    String _todaystring = DateFormat('yyyyMMdd').format(
      DateTime.now().subtract(Duration(days: 1)),
    );
    DateTime _today = DateTime.parse(_todaystring);
    for (int i = 0; i < widget.marked.dates.length; i++) {
      if (widget.marked.dates[i].date.isAfter(_today)) {
        _date.add(widget.marked.dates[i]);
      }
    }
    _loading = false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().marked,
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
                  Customized().onlymarketnameaddress(
                    size,
                    () {},
                    widget.marked.name,
                    '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.04,
                    ),
                    child: Text(
                      ConstantValue().producavailable,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: ConstantValue().text,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ConstantValue().nextmarkedday,
                      style: TextStyle(
                        color: ConstantValue().text,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.01),
                  _date.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _date.length,
                          itemBuilder: (context, i) => StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .reference()
                                .child('Marked')
                                .child(widget.marked.id)
                                .child('Sellers')
                                .child(_phone)
                                .child('Dates')
                                .child(DateFormat('yyyyMMdd')
                                    .format(_date[i].date))
                                .onValue,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<dynamic> snap,
                            ) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Customized().loading();
                              } else {
                                if (snap.hasData &&
                                    !snap.hasError &&
                                    snap.data.snapshot.value != null) {
                                  bool data = snap.data.snapshot.value['Join'];
                                  return Customized().joinorjoinedmarketstemp(
                                    size,
                                    () {},
                                    '${_date[i].day} ${DateFormat('dd/MM/yyyy').format(_date[i].date)}',
                                    data,
                                    false,
                                  );
                                } else {
                                  return Customized().joinorjoinedmarketstemp(
                                    size,
                                    () {
                                      setState(() {
                                        _queryrun = true;
                                      });
                                      Provider.of<Back>(context, listen: false)
                                          .joinsetdate(
                                        widget.marked.id,
                                        _phone,
                                        DateFormat('yyyyMMdd')
                                            .format(_date[i].date),
                                        () {
                                          setState(() {
                                            _queryrun = false;
                                          });
                                          Customized().truediload(
                                            ConstantValue().t4,
                                            context,
                                            size,
                                          );
                                        },
                                        (String error) {
                                          Customized().snak(error, context);
                                        },
                                      );
                                    },
                                    '${_date[i].day} ${DateFormat('dd/MM/yyyy').format(_date[i].date)}',
                                    false,
                                    _queryrun,
                                  );
                                }
                              }
                            },
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'No any Future Date Declared Yet !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstantValue().redi,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Row(
                      children: [
                        Text(
                          ConstantValue().smsalert,
                          style: TextStyle(
                            color: ConstantValue().text,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Customized().sizedwidth(size.width * 0.04),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      ConstantValue().yes,
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        color: ConstantValue().text,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _no = false;
                                          _yes = true;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.04),
                                        width: size.width * 0.06,
                                        height: size.width * 0.06,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: ConstantValue().text,
                                          ),
                                          shape: BoxShape.circle,
                                          color: _yes
                                              ? ConstantValue().greene
                                              : ConstantValue().white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      ConstantValue().no,
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        color: ConstantValue().text,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _yes = false;
                                          _no = true;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.04),
                                        width: size.width * 0.06,
                                        height: size.width * 0.06,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: ConstantValue().text,
                                          ),
                                          shape: BoxShape.circle,
                                          color: _no
                                              ? ConstantValue().greene
                                              : ConstantValue().white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
