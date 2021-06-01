import 'package:flutter/material.dart';

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
              leading: Container(),
              title: Center(child: Text("Actions"),),
              automaticallyImplyLeading: false,
              actions: [
                BackButton(),
              ],
            ),
            Divider(),

            // Container(
            //   decoration: BoxDecoration(color: Theme.of(context).primaryColor, border: Border(bottom: BorderSide(),),),
            //   height: 100,
            //   child: Center(
            //     child: Text('Actions', style: TextStyle(fontSize: 40),),
            //   ),
            //   padding: EdgeInsets.only(top: 30),
            // ),
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
