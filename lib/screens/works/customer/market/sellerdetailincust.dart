import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class SellerDetailInCust extends StatefulWidget {
  final SellerCust seller;
  final OnlyOneMarkedCust marked;
  SellerDetailInCust(this.seller, this.marked);

  @override
  _SellerDetailInCustState createState() => _SellerDetailInCustState();
}

class _SellerDetailInCustState extends State<SellerDetailInCust> {
  List<CustProd> _prod = [];
  bool _loading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).fetchprodcust(
          widget.seller.phone,
          (List<CustProd> prod) {
            _prod = prod;
            _loading = false;
            setState(() {});
          },
          () {
            setState(() {
              _loading = false;
            });
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
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().sellerdetail,
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
          : Stack(
              children: [
                Column(
                  children: [
                    Container(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Customized().makeorderfirststemp(
                              size,
                              widget.seller,
                              widget.marked,
                            ),
                            Customized().sizedheight(size.height * 0.015),
                            _prod.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: _prod.length,
                                    itemBuilder: (context, i) =>
                                        ProductStempWidget(
                                      _prod[i],
                                      widget.seller,
                                      widget.marked,
                                    ),
                                  )
                                : Customized().dnfsmall(size),
                            Customized().sizedheight(size.height * 0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                PosiButton(_phone, widget.seller, widget.marked),
              ],
            ),
    );
  }
}
