import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

import '../../../../all.dart';

class MarketDetailScreen extends StatefulWidget {
  final OnlyOneMarkedCust marked;
  MarketDetailScreen(this.marked);
  @override
  _MarketDetailScreenState createState() => _MarketDetailScreenState();
}

class _MarketDetailScreenState extends State<MarketDetailScreen> {
  String? _filter;
  bool _loading = true;
  List<SellerCust> _seller = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).fetchSellCust(
          widget.marked.seller,
          (List<SellerCust> sel) {
            _seller = sel;
            _loading = false;
            setState(() {});
          },
          (String error) {
            Customized().snak(error, context);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().marketdetail,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/CustomerDashboard'),
          );
        },
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Customized().marketStemp(
                    size,
                    () {},
                    widget.marked.name,
                    '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
                    '${widget.marked.day} ${DateFormat('dd/MM/yyyy').format(widget.marked.date)}',
                  ),
                  Customized().sizedheight(size.height * 0.01),
                  Customized().customdropdown(
                    size,
                    _filter,
                    (String? value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                    widget.marked.category,
                    'Filter by Category',
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  _seller.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _seller.length,
                          itemBuilder: (context, i) =>
                              Customized().sellerStempinMarket(
                            size,
                            () {
                              Customized().naviagt(
                                context,
                                SellerDetailInCust(_seller[i], widget.marked),
                              );
                            },
                            _seller[i].company,
                          ),
                        )
                      : Column(
                          children: [
                            Customized().sizedheight(size.height * 0.04),
                            Customized().dnfsmall(size),
                          ],
                        ),
                  Customized().sizedheight(size.height * 0.02),
                ],
              ),
            ),
    );
  }
}
