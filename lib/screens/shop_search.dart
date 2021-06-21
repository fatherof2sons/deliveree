import 'package:delivaree/model/data.dart';
import 'package:delivaree/model/shop.dart';
import 'package:delivaree/screens/shop.dart';
import 'package:flutter/material.dart';

class ShopSearch extends SearchDelegate {
  final List<Shop> shops = Data.shopData;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () => query = "",
          child: Icon(
            Icons.clear_rounded,
            color: Colors.grey,
          )),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return IconButton(
      onPressed: () {
        close(
          context,
          null,
        );

        currentFocus.unfocus();
      },
      icon: Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final shopNames = shops.map<String>((e) => "${e.name}").toList();
    final res = shopNames
        .where((element) => element.toLowerCase().contains(query))
        .toList();
    // final result = shops
    //     .where((element) => element.toLowerCase().contains(query))
    //     .toList();

    if (query.length == 0) return NoQueryScreen();

    return ListView.builder(
        itemCount: res.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final resShop =
              shops.where((element) => element.name == res[index]).toList();
          return ListTile(
            title: Text("${resShop[index].name}"),
            leading: Image.asset("${resShop[index].photo}"),
            subtitle: Text("${resShop[index].type}"),
            onTap: () {
              close(context, null);
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ShopPage(
                    shop: resShop[0],
                  ),
                ),
              );
            },
          );
        });
  }
}

class NoQueryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'search\nfor\nstores',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
          Icon(
            Icons.search,
            size: 120.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
