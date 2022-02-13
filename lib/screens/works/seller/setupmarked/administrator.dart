import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class Administrator extends StatelessWidget {
  final String id;
  Administrator(this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phone = Provider.of<Back>(context, listen: false).me!.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Marked')
        .child(id)
        .child('Admins')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appbarwithicon(
        size,
        ConstantValue().administrator,
        () {
          Customized().naviagt(
            context,
            AdministratorAdd(id),
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
              List<String> _adminid = [];
              data.forEach(
                (key, value) {
                  if (value != _phone) {
                    _adminid.add(value);
                  }
                },
              );
              return _adminid.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _adminid.length,
                      itemBuilder: (context, i) => StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Users')
                            .child(_adminid[i])
                            .onValue,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snap,
                        ) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Customized().categoryshimmer(size);
                          } else {
                            if (snap.hasData &&
                                !snap.hasError &&
                                snap.data.snapshot.value != null) {
                              AdminSetup? _admin;
                              _admin = AdminSetup(
                                id: snap.data.snapshot.key,
                                name: snap.data.snapshot.value['CompanyName'],
                                email: snap.data.snapshot.value['Email-Id'],
                                password: snap.data.snapshot.value['Password'],
                                //position: snap.data.snapshot.value['Who'],
                              );
                              return Customized().singlecategory(
                                size,
                                _admin.name,
                                () {
                                  Customized().naviagt(
                                    context,
                                    Administratorupdate(_admin!),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
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
