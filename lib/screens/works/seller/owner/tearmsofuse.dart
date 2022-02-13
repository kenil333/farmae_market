import 'package:flutter/material.dart';

import '../../../../all.dart';

class TearmsOfUseset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().tearmsofuse,
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
              '${ConstantValue().tearmsofuse} App',
              () {
                Customized().naviagt(
                  context,
                  AllTearmsofUseset(
                    '${ConstantValue().tearmsofuse} App',
                  ),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              '${ConstantValue().tearmsofuse} ${ConstantValue().seller}',
              () {
                Customized().naviagt(
                  context,
                  AllTearmsofUseset(
                    '${ConstantValue().tearmsofuse} ${ConstantValue().seller}',
                  ),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              '${ConstantValue().tearmsofuse} ${ConstantValue().customer}',
              () {
                Customized().naviagt(
                  context,
                  AllTearmsofUseset(
                    '${ConstantValue().tearmsofuse} ${ConstantValue().customer}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
