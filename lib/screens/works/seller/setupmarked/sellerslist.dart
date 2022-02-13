import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../all.dart';

class SellersListScreens extends StatefulWidget {
  final String id;
  SellersListScreens(this.id);
  @override
  _SellersListScreensState createState() => _SellersListScreensState();
}

class _SellersListScreensState extends State<SellersListScreens> {
  TextEditingController _search = TextEditingController();
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
        ConstantValue().sellers,
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
              List<String> _sellrid = [];
              data.forEach(
                (key, value) {
                  _sellrid.add(key);
                },
              );
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Customized().sizedheight(size.height * 0.01),
                    Customized().searchwidget(
                      size,
                      'Search',
                      _search,
                      () {},
                    ),
                    Customized().sizedheight(size.height * 0.02),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _sellrid.length,
                      itemBuilder: (context, i) => StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Users')
                            .child(_sellrid[i])
                            .onValue,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snap,
                        ) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Customized().sellerinsetupshimmer(size);
                          } else {
                            if (snap.hasData &&
                                !snap.hasError &&
                                snap.data.snapshot.value != null) {
                              SellerDeta? _seller;
                              _seller = SellerDeta(
                                company:
                                    snap.data.snapshot.value['CompanyName'],
                                phone: snap.data.snapshot.key,
                                emial: snap.data.snapshot.value['Email-Id'],
                                org: snap.data.snapshot.value['OrgNo'],
                              );
                              return Column(
                                children: [
                                  Customized().sellernameimage(
                                    size,
                                    () {
                                      Customized().naviagt(
                                        context,
                                        SellerInformation(_seller),
                                      );
                                    },
                                    _seller.company,
                                  ),
                                  Container(
                                    height: 1,
                                    color: ConstantValue().text,
                                    width: double.infinity,
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
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
