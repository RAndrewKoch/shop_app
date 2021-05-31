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
            Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, border: Border(bottom: BorderSide(),),),
              height: 100,
              child: Center(
                child: Text('Actions', style: TextStyle(fontSize: 40),),
              ),
              padding: EdgeInsets.only(top: 30),
            ),
            Container(
              height: 400,
              child: ListView(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(OrdersScreen.routeName),
                    child: Text(
                      "Orders",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(ProductsOverviewScreen.routeName),
                    child: Text(
                      "Products Overview",
                      style: TextStyle(color: Colors.black),
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
