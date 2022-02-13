import 'package:flutter/material.dart';

import '../../../../../all.dart';

class SettingsMarked extends StatelessWidget {
  final String id;
  SettingsMarked(this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().setting,
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
              '${ConstantValue().set} ${ConstantValue().saletearms}',
              () {
                Customized().naviagt(
                  context,
                  SetSaleofTearms(id),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().joinfreeapprove,
              () {
                Customized().naviagt(
                  context,
                  JoinFreeorApprove(id),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              '${ConstantValue().set} ${ConstantValue().applicatoiontext}',
              () {
                Customized().naviagt(
                  context,
                  SetApplicationText(id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
