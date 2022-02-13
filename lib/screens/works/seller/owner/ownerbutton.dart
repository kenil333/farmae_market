import 'package:flutter/material.dart';

import '../../../../all.dart';

class OwnerButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().owner,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().stempOfNameIcon(
              size,
              ConstantValue().commision,
              () {
                Customized().naviagt(
                  context,
                  CommitionsScreen(),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().marketplace,
              () {
                Customized().naviagt(
                  context,
                  MarketPlaceScreen(),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().sellers,
              () {
                Customized().naviagt(
                  context,
                  SellersListinOwner(),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().customers,
              () {
                Customized().naviagt(
                  context,
                  CustomerListOwner(),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().tearmsofuse,
              () {
                Customized().naviagt(
                  context,
                  TearmsOfUseset(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
