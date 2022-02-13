import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class SellerInformation extends StatefulWidget {
  final SellerDeta? seller;
  SellerInformation(this.seller);
  @override
  _SellerInformationState createState() => _SellerInformationState();
}

class _SellerInformationState extends State<SellerInformation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(widget.seller!.phone)
        .child('Block')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().sellerdetail,
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
            Customized().detailStemp(
              size,
              ConstantValue().company,
              widget.seller!.company,
            ),
            Customized().detailStemp(
              size,
              ConstantValue().mobile,
              widget.seller!.phone,
            ),
            Customized().detailStemp(
              size,
              ConstantValue().email,
              widget.seller!.emial,
            ),
            Customized().detailStemp(
              size,
              ConstantValue().orgno,
              widget.seller!.org,
            ),
            Customized().sizedheight(size.height * 0.03),
            StreamBuilder(
              stream: api,
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snap,
              ) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Customized().loading();
                } else {
                  bool _block = snap.data.snapshot.value;
                  return Customized().customButton(
                    size,
                    _block ? ConstantValue().unblock : ConstantValue().block,
                    ConstantValue().redi,
                    () {
                      Provider.of<Back>(context, listen: false).blockunblock(
                        widget.seller!.phone,
                        _block ? false : true,
                        () {
                          Customized().truediload(
                            _block ? ConstantValue().t6 : ConstantValue().t5,
                            context,
                            size,
                          );
                        },
                        (String error) {
                          Customized().snak(error, context);
                        },
                      );
                    },
                  );
                }
              },
            ),
            Customized().sizedheight(size.height * 0.08),
          ],
        ),
      ),
    );
  }
}
