import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../all.dart';

class ConfirmOrderProdStemp extends StatelessWidget {
  final SellerCust seller;
  final CartProd product;
  final String phone;
  ConfirmOrderProdStemp(this.seller, this.product, this.phone);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CustProd _prod =
        Provider.of<Back>(context, listen: false).singleprod(product.id);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
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
              imageUrl: _prod.image,
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
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _prod.name,
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Customized().sizedheight(size.height * 0.002),
                                Text(
                                  'Kr ${_prod.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<Back>(context, listen: false)
                                      .addorremovecart(
                                    phone,
                                    seller.phone,
                                    product.id,
                                    _prod.price,
                                    product.count,
                                    false,
                                  );
                                },
                                child: Icon(
                                  Icons.remove_circle,
                                  size: size.width * 0.075,
                                  color: ConstantValue().greene,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.012,
                                ),
                                child: Text(
                                  '${product.count}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.06,
                                    fontWeight: FontWeight.bold,
                                    color: ConstantValue().greene,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<Back>(context, listen: false)
                                      .addorremovecart(
                                    phone,
                                    seller.phone,
                                    product.id,
                                    _prod.price,
                                    product.count,
                                    true,
                                  );
                                },
                                child: Icon(
                                  Icons.add_circle,
                                  size: size.width * 0.075,
                                  color: ConstantValue().greene,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.012),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                            ),
                            child: Text(
                              '${product.count} stk x ${_prod.price.toStringAsFixed(2)} Kr = ',
                              style: TextStyle(
                                color: ConstantValue().text,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Kr ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: ConstantValue().text,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
