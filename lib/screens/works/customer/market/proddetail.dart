import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class ProdDetailScreen extends StatelessWidget {
  final CustProd prod;
  final SellerCust sell;
  final OnlyOneMarkedCust marked;
  ProdDetailScreen(this.prod, this.sell, this.marked);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().productdetail,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/CustomerDashboard'),
          );
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Customized().sizedheight(size.height * 0.00),
                      Customized().sellernameimage(
                        size,
                        () {},
                        sell.company,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.02,
                        ),
                        width: double.infinity,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          color: ConstantValue().white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: ConstantValue().text.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: CachedNetworkImage(
                          imageUrl: prod.image,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                      ProdNameandCount(prod, sell),
                      Customized().sizedheight(size.height * 0.12),
                    ],
                  ),
                ),
              ),
            ],
          ),
          PosiButton(_phone, sell, marked),
        ],
      ),
    );
  }
}
