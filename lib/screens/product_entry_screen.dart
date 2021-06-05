import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';



import '../widgets/side_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';


class ProductEntry extends StatelessWidget {
  static const String routeName = "/productEntry";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Entry"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {Navigator.pushNamed(context, EditProductScreen.routeName);},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: ((context, i) =>
                UserProductItem(product: productsData.items[i])),
            itemCount: productsData.items.length,),),
      ),
      drawer: SideDrawer(),
    );
  }
}
