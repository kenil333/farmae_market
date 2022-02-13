import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class FindMarkedPlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Marked').onValue;
    final _phone = Provider.of<Back>(context, listen: false).me!.phone;
    final String _s = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 1)));
    final DateTime _d = DateTime.parse(_s);
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().findmarkedplace,
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
              List<FindMarkedClass> _marked = [];
              List<FindMarkedClass> _mymarked = [];
              List<String> _country = ["Show All"];
              data.forEach(
                (key, value) {
                  if (value['DateSeller'] != null &&
                      value['FreeToJoin'] != null) {
                    List<DateAndDay> _dates = [];
                    value['DateSeller'].forEach(
                      (ke, val) {
                        if (DateTime.parse(ke).isAfter(_d)) {
                          _dates.add(
                            DateAndDay(
                              date: DateTime.parse(ke),
                              day: val['Day'],
                              sels: int.parse(
                                val['Sellers'],
                              ),
                            ),
                          );
                        }
                        if (_dates.length > 1) {
                          _dates.sort((a, b) {
                            return a.date.compareTo(b.date);
                          });
                        }
                      },
                    );
                    if (_dates.isNotEmpty) {
                      if (value['Sellers'] != null) {
                        bool _found = false;
                        value['Sellers'].forEach(
                          (k, v) {
                            if (k == _phone) {
                              _found = true;
                            }
                          },
                        );
                        if (_found) {
                          _mymarked.add(
                            FindMarkedClass(
                              id: key,
                              name: value['Name'],
                              street: value['Street'],
                              city: value['City'],
                              postcode: value['PostCode'],
                              country: value['Country'],
                              dates: _dates,
                              free: value['FreeToJoin'],
                              admintext: value['AdminText'],
                            ),
                          );
                        } else {
                          _marked.add(
                            FindMarkedClass(
                              id: key,
                              name: value['Name'],
                              street: value['Street'],
                              city: value['City'],
                              postcode: value['PostCode'],
                              country: value['Country'],
                              dates: _dates,
                              free: value['FreeToJoin'],
                              admintext: value['AdminText'],
                            ),
                          );
                          if (!_country.contains(value['Country'])) {
                            _country.add(value['Country']);
                          }
                        }
                      } else {
                        _marked.add(
                          FindMarkedClass(
                            id: key,
                            name: value['Name'],
                            street: value['Street'],
                            city: value['City'],
                            postcode: value['PostCode'],
                            country: value['Country'],
                            dates: _dates,
                            free: value['FreeToJoin'],
                            admintext: value['AdminText'],
                          ),
                        );
                        if (!_country.contains(value['Country'])) {
                          _country.add(value['Country']);
                        }
                      }
                    }
                  }
                },
              );
              if (_mymarked.length > 1) {
                _mymarked.sort(
                  (a, b) {
                    return a.dates[0].date.compareTo(b.dates[0].date);
                  },
                );
              }
              if (_marked.length > 1) {
                _marked.sort(
                  (a, b) {
                    return a.dates[0].date.compareTo(b.dates[0].date);
                  },
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Customized().sizedheight(size.height * 0.02),
                    Customized().customButton(
                      size,
                      ConstantValue().findnewmarkedplace,
                      ConstantValue().greene,
                      () {
                        Customized().naviagt(
                          context,
                          FindNewMarketScreen(_marked, _country),
                        );
                      },
                    ),
                    Customized().sizedheight(size.height * 0.03),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Text(
                        'My Markets :',
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: ConstantValue().text,
                        ),
                      ),
                    ),
                    Customized().sizedheight(size.height * 0.01),
                    _mymarked.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _mymarked.length,
                            itemBuilder: (context, i) => Stack(
                              children: [
                                Customized().marketStemp(
                                  size,
                                  () {
                                    Customized().naviagt(
                                      context,
                                      MarketJoinSetScreen(_mymarked[i]),
                                    );
                                  },
                                  _mymarked[i].name,
                                  '${_mymarked[i].street}, ${_mymarked[i].postcode} ${_mymarked[i].city}',
                                  '${_mymarked[i].dates[0].day} ${DateFormat('dd/MM/yyyy').format(_mymarked[i].dates[0].date)}',
                                ),
                                // Positioned(
                                //   top: size.height * 0.003,
                                //   right: size.width * 0.02,
                                //   child: Container(
                                //     width: size.width * 0.08,
                                //     height: size.width * 0.08,
                                //     decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: ConstantValue().redi,
                                //     ),
                                //     alignment: Alignment.center,
                                //     child: Text(
                                //       '0',
                                //       style: TextStyle(
                                //         color: ConstantValue().white,
                                //         fontSize: size.width * 0.038,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Customized().sizedheight(size.height * 0.04),
                              Customized().dnfsmall(size),
                            ],
                          ),
                    Customized().sizedheight(size.height * 0.02),
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
