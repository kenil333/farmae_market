import 'package:flutter/material.dart';

import '../../../../all.dart';

class FindNewMarketScreen extends StatefulWidget {
  final List<FindMarkedClass> marked;
  final List<String> country;
  FindNewMarketScreen(this.marked, this.country);
  @override
  _FindNewMarketScreenState createState() => _FindNewMarketScreenState();
}

class _FindNewMarketScreenState extends State<FindNewMarketScreen> {
  String? _filter = "Show All";
  List<FindMarkedClass> _mark = [];

  @override
  void initState() {
    _mark = widget.marked;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().findmarket,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.02),
            Customized().customdropdown(
              size,
              _filter,
              (String? value) {
                _filter = value;
                if (value == "Show All") {
                  _mark = widget.marked;
                  setState(() {});
                } else {
                  List<FindMarkedClass> _dummy = [];
                  for (int i = 0; i < widget.marked.length; i++) {
                    if (widget.marked[i].country == value) {
                      _dummy.add(widget.marked[i]);
                    }
                  }
                  _mark = _dummy;
                  setState(() {});
                }
              },
              widget.country,
              'Filter by Country',
            ),
            Customized().sizedheight(size.height * 0.01),
            _mark.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _mark.length,
                    itemBuilder: (context, i) =>
                        Customized().findnewmarketStemp(
                      size,
                      () {
                        Customized().naviagt(
                          context,
                          DeliverAppliFindMarket(_mark[i]),
                        );
                      },
                      _mark[i].free,
                      _mark[i].name,
                      '${_mark[i].street}, ${_mark[i].postcode} ${_mark[i].city}',
                    ),
                  )
                : Column(
                    children: [
                      Customized().sizedheight(size.height * 0.04),
                      Customized().dnfsmall(size),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
