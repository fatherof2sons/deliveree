import 'package:delivaree/model/shop.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key, @required this.shop}) : super(key: key);
  final Shop? shop;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${shop?.name}'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.clear_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            currentFocus.unfocus();
          },
        ),
        backgroundColor: Color(0XFFE76A6A),
      ),
      body: Center(
        child: Text("phone: ${shop?.phone}\nviber: ${shop?.viber}"),
      ),
    );
  }
}
