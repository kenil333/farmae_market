import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../all.dart';

class MarketsOfSellers extends StatelessWidget {
  final List<MarkedInSelOwner> marked;
  MarketsOfSellers(this.marked);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (marked.length > 1) {
      marked.sort((a, b) {
        return a.date.compareTo(b.date);
      });
    }
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().markets,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: marked.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: marked.length,
              itemBuilder: (context, i) => Customized().marketStemp(
                size,
                () {},
                marked[i].name,
                '${marked[i].street}, ${marked[i].postcode} ${marked[i].city}',
                '${marked[i].day} ${DateFormat('dd/MM/yyyy').format(marked[i].date)}',
              ),
            )
          : Customized().datanot(size),
    );
  }
}
