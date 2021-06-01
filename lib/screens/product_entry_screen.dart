import 'package:flutter/material.dart';

import '../widgets/side_drawer.dart';

class ProductEntry extends StatelessWidget {
  static const String routeName = "/productEntry";

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Product Entry"),
      ),
      drawer: SideDrawer(),
    );
  }
}
