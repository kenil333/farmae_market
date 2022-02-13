import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class MarkedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    final String _who = Provider.of<Back>(context, listen: false).me!.who;
    final api = FirebaseDatabase.instance.reference().child('Marked').onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: _who == ConstantValue().owner
          ? Customized().appbarwithicon(
              size,
              ConstantValue().marked,
              () {
                Customized().naviagt(
                  context,
                  AddMarked(),
                );
              },
            )
          : Customized().appBarforlimit(
              size,
              ConstantValue().markeddate,
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
              List<MarkedInSetup> _marked = [];
              data.forEach(
                (key, value) {
                  if (_who == ConstantValue().owner) {
                    _marked.add(
                      MarkedInSetup(
                        id: key,
                        name: value['Name'],
                        street: value['Street'],
                        city: value['City'],
                        postcode: value['PostCode'],
                        country: value['Country'],
                      ),
                    );
                  } else {
                    if (value['Admins'] != null) {
                      bool _found = false;
                      value['Admins'].forEach(
                        (akey, avalue) {
                          if (_phone == avalue) {
                            _found = true;
                          }
                        },
                      );
                      if (_found) {
                        _marked.add(
                          MarkedInSetup(
                            id: key,
                            name: value['Name'],
                            street: value['Street'],
                            city: value['City'],
                            postcode: value['PostCode'],
                            country: value['Country'],
                          ),
                        );
                      }
                    }
                  }
                },
              );
              return _marked.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _marked.length,
                      itemBuilder: (context, i) =>
                          Customized().onlymarketnameaddress(
                        size,
                        () {
                          Customized().naviagt(
                            context,
                            MarkedDashboardScreen(
                              _marked[i].name,
                              '${_marked[i].street}, ${_marked[i].postcode} ${_marked[i].city}',
                              _marked[i].id,
                            ),
                          );
                        },
                        _marked[i].name,
                        '${_marked[i].street}, ${_marked[i].postcode} ${_marked[i].city}',
                      ),
                    )
                  : Center(
                      child: Customized().datanot(size),
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
