import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../all.dart';

class ProdNameandCount extends StatelessWidget {
  final CustProd product;
  final SellerCust seller;
  ProdNameandCount(this.product, this.seller);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.04,
          ),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Customized().sizedheight(size.height * 0.002),
                      Text(
                        'Kr ${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AddorRemove(
                seller,
                product,
                _phone,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          width: double.infinity,
          child: Text(
            product.description,
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
