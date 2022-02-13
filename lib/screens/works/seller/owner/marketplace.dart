import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../all.dart';

class MarketPlaceScreen extends StatefulWidget {
  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  String? _country = 'Show All';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Marked').onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().marketplace,
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
              List<MarkedInOwner> _marked = [];
              List<String> _cont = ['Show All'];
              data.forEach(
                (key, value) {
                  if (!_cont.contains(value['Country'])) {
                    _cont.add(value['Country']);
                  }
                  if (_country == value['Country']) {
                    List<String> _sellers = [];
                    if (value['Sellers'] != null) {
                      value['Sellers'].forEach(
                        (ka, va) {
                          _sellers.add(ka);
                        },
                      );
                    }
                    _marked.add(
                      MarkedInOwner(
                        id: key,
                        name: value['Name'],
                        street: value['Street'],
                        city: value['City'],
                        postcode: value['PostCode'],
                        country: value['Country'],
                        sellers: _sellers,
                      ),
                    );
                  }
                  if (_country == 'Show All') {
                    List<String> _sellers = [];
                    if (value['Sellers'] != null) {
                      value['Sellers'].forEach(
                        (ka, va) {
                          _sellers.add(ka);
                        },
                      );
                    }
                    _marked.add(
                      MarkedInOwner(
                        id: key,
                        name: value['Name'],
                        street: value['Street'],
                        city: value['City'],
                        postcode: value['PostCode'],
                        country: value['Country'],
                        sellers: _sellers,
                      ),
                    );
                  }
                },
              );
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Customized().sizedheight(size.height * 0.02),
                    Customized().customdropdown(
                      size,
                      _country,
                      (String? value) {
                        setState(() {
                          _country = value;
                        });
                      },
                      _cont,
                      'Filter by Country',
                    ),
                    Customized().sizedheight(size.height * 0.01),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _marked.length,
                      itemBuilder: (context, i) =>
                          Customized().onlymarketnameaddress(
                        size,
                        () {
                          Customized().naviagt(
                            context,
                            MarketPlaceInfoScreen(_marked[i]),
                          );
                        },
                        _marked[i].name,
                        '${_marked[i].street}, ${_marked[i].postcode} ${_marked[i].city}',
                      ),
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
