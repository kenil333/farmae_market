import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class MarketPlaceInfoScreen extends StatefulWidget {
  final MarkedInOwner marked;
  MarketPlaceInfoScreen(this.marked);

  @override
  _MarketPlaceInfoScreenState createState() => _MarketPlaceInfoScreenState();
}

class _MarketPlaceInfoScreenState extends State<MarketPlaceInfoScreen> {
  bool _loading = true;
  int _sels = 0;
  double _income = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).salandincom(
          widget.marked.id,
          (int count, double tot) {
            setState(() {
              _sels = count;
              _income = tot;
              _loading = false;
              setState(() {});
            });
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
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().marketplace,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
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
                  Customized().onlymarketnameaddress(
                    size,
                    () {},
                    widget.marked.name,
                    '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
                  ),
                  Customized().totsalandanother(
                    size,
                    widget.marked.sellers.length.toString(),
                    _sels.toString(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: size.height * 0.03),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ConstantValue().stattotal,
                          style: TextStyle(
                            color: ConstantValue().text,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.07,
                          ),
                        ),
                        Text(
                          'Kr ${_income.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: ConstantValue().greene,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.07,
                          ),
                        )
                      ],
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().customButton(
                    size,
                    ConstantValue().adminoverview,
                    ConstantValue().text,
                    () {
                      Customized().naviagt(
                        context,
                        MarkedDashboardScreen(
                          widget.marked.name,
                          '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
                          widget.marked.id,
                        ),
                      );
                    },
                  ),
                  Customized().sizedheight(size.height * 0.04),
                ],
              ),
            ),
    );
  }
}
