import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../all.dart';

class EndAppDrawer extends StatelessWidget {
  final String who;
  EndAppDrawer(this.who);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _menuItem(
      Size size,
      String title,
      IconData icon,
      Function func,
    ) {
      return InkWell(
        onTap: () {
          func();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: Row(
            children: [
              Customized().sizedwidth(size.width * 0.07),
              Icon(
                icon,
                color: ConstantValue().text,
                size: size.width * 0.08,
              ),
              Customized().sizedwidth(size.width * 0.08),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantValue().text,
                  fontSize: size.width * 0.05,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: size.width * 0.9,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(ConstantValue().appicon),
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                    ),
                    Customized().sizedwidth(size.width * 0.05),
                    Text(
                      ConstantValue().appname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ConstantValue().zeri,
                        fontSize: size.width * 0.06,
                      ),
                    )
                  ],
                ),
              ),
              _menuItem(
                size,
                ConstantValue().mypage,
                Icons.my_library_books,
                () {
                  Customized().naviagt(
                    context,
                    MyPageScreen(),
                  );
                },
              ),
              _menuItem(
                size,
                ConstantValue().tipsforapp,
                Icons.ad_units,
                () {
                  Customized().naviagt(
                    context,
                    ImproveTipsScreen(),
                  );
                },
              ),
              _menuItem(
                size,
                ConstantValue().contactus,
                Icons.support_agent_rounded,
                () {
                  Customized().naviagt(
                    context,
                    ContactUsScreen(),
                  );
                },
              ),
              _menuItem(
                size,
                ConstantValue().setting,
                Icons.settings,
                () {},
              ),
              _menuItem(
                size,
                ConstantValue().logout,
                Icons.exit_to_app,
                () {
                  Provider.of<Back>(context, listen: false).logout(
                    () {
                      if (who == ConstantValue().seller) {
                        Navigator.of(context).popUntil(
                          ModalRoute.withName('/SellerDashboard'),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            settings: RouteSettings(name: '/UserType'),
                            builder: (context) => UserType(),
                          ),
                        );
                      } else {
                        Navigator.of(context).popUntil(
                          ModalRoute.withName('/CustomerDashboard'),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            settings: RouteSettings(name: '/UserType'),
                            builder: (context) => UserType(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
