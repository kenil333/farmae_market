import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../all.dart';

class ProductStempWidget extends StatelessWidget {
  final CustProd product;
  final SellerCust seller;
  final OnlyOneMarkedCust marked;
  ProductStempWidget(this.product, this.seller, this.marked);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      child: InkWell(
        onTap: () {
          Customized().naviagt(
            context,
            ProdDetailScreen(
              product,
              seller,
              marked,
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ConstantValue().white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 20,
                color: ConstantValue().text.withOpacity(0.23),
              ),
            ],
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: size.width * 0.2,
                height: size.width * 0.2,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Customized().sizedheight(size.height * 0.002),
                      Text(
                        'Kr ${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.04,
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
      ),
    );
  }
}
