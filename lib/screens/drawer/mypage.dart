import 'package:flutter/material.dart';

import './../../all.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().mypage,
        () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().stempOfNameIcon(
              size,
              ConstantValue().cotactinfo,
              () {
                Customized().naviagt(
                  context,
                  ContactIfo(),
                );
              },
            ),
            Customized().stempOfNameIcon(
              size,
              ConstantValue().orderpdf,
              () {},
            ),
          ],
        ),
      ),
    );
  }
}
