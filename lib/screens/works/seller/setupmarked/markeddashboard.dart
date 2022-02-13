import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class MarkedDashboardScreen extends StatelessWidget {
  final String name;
  final String address;
  final String id;
  MarkedDashboardScreen(this.name, this.address, this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _who = Provider.of<Back>(context, listen: false).me!.who;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().marked,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().onlymarketnameaddress(
              size,
              () {},
              name,
              address,
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().markeddate,
              () {
                Customized().naviagt(
                  context,
                  MarkedDateScreen(id),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().sellers,
              () {
                Customized().naviagt(
                  context,
                  SellersListScreens(id),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().categories,
              () {
                Customized().naviagt(
                  context,
                  CategoryList(id),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().setting,
              () {
                Customized().naviagt(
                  context,
                  SettingsMarked(id),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().markedinfo,
              () {
                Customized().naviagt(
                  context,
                  MarkedInfoDetailScreen(id),
                );
              },
            ),
            _who == ConstantValue().admin
                ? Container()
                : Customized().stempOfNameIcon(
                    size,
                    ConstantValue().administrator,
                    () {
                      Customized().naviagt(
                        context,
                        Administrator(id),
                      );
                    },
                  ),
            _who == ConstantValue().admin
                ? Container()
                : Customized().stempOfNameIcon(
                    size,
                    ConstantValue().commisionfee,
                    () {
                      Customized().naviagt(
                        context,
                        CommistionFess(id),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
