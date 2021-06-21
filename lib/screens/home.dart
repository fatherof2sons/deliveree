import 'package:delivaree/screens/shop_register.dart';
import 'package:delivaree/screens/shop_search.dart';
import 'package:delivaree/widgets/home_main_text.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HomeMainText(
          height: 40.0,
          onLongPress: () {
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ShopRegisterPage()));
          },
        ),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 80.0,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 33.0),
                Text(
                  "Search for shops, cafe's and restaurants etc...\nYou Name It!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 38.0,
                    letterSpacing: 2.0,
                    fontFamily: "Nunito",
                  ),
                ),
                SizedBox(height: 60.0),
                TextField(
                  onTap: () {
                    showSearch(context: context, delegate: ShopSearch());
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'search',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                      prefix: SizedBox(width: 12.0),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
              ],
            ),
          ),
          // top background image
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Image.asset(
              'assets/images/DESIGN.png',
              width: 160.0,
              fit: BoxFit.fill,
            ),
          ),
          // bottom background image
          Positioned(
            bottom: 0.0,
            child: Image.asset(
              'assets/images/bottom_design.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
