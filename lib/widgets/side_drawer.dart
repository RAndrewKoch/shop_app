import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/product_entry_screen.dart';

import '../screens/orders_screen.dart';
import '../screens/products_overview_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            AppBar(
              toolbarHeight: MediaQuery.of(context).size.height*.10,
              leading: Container(),
              title: Center(child: Text("Actions"),),
              automaticallyImplyLeading: false,
              actions: [
                BackButton(),
              ],
            ),
            Divider(),

            Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              height: MediaQuery.of(context).size.height * .8,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.shop),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(OrdersScreen.routeName),
                      title: Text(
                        "Orders",
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.payment),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(ProductsOverviewScreen.routeName),
                      title: Text(
                        "Products Overview",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.add_business),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(ProductEntry.routeName),
                      title: Text(
                        "Products Entry",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      onTap: () {
                        Navigator.of(context).pop();
                        Provider.of<Auth>(context, listen:false,).logout(context);},
                      title: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
